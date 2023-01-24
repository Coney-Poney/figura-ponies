-- ┌───┐                ┌───┐ --
-- │ ┌─┘ ┌─────┐┌─────┐ └─┐ │ --
-- │ │   │ ┌───┘│ ╶───┤   │ │ --
-- │ │   │ ├───┐└───┐ │   │ │ --
-- │ │   │ └─╴ │┌───┘ │   │ │ --
-- │ └─┐ └─────┘└─────┘ ┌─┘ │ --
-- └───┘                └───┘ --
---@module  "Animation Blend Library" <GSAnimBlend>
---@version v1.5.2
---@see     GrandpaScout @ https://github.com/GrandpaScout
-- Adds prewrite-like animation blending to the rewrite.
-- Also includes the ability to modify how the blending works per-animation with blending callbacks.
--
-- Simply `require`ing this function is enough to make it run. However, if you place this library in
-- a variable, you can get access to functions and tools that allow for generating pre-build blend
-- callbacks or creating your own blend callbacks.
--
-- This library is fully documented. If you use Sumneko's Lua Language server, you will get
-- descriptions of each function, method, and field in this library.

local ID = "GSAnimBlend"
local VER = "1.5.2"
local FIG = {"0.1.0-rc.9", "0.1.0-rc.14"}

do local cmp, ver = client.compareVersions, client.getFiguraVersion()
  assert(
    not FIG[1] or cmp(ver, FIG[1]) >= 0,
    ("Your Figura version (%s) is below the minimum of %s"):format(ver, FIG[1])
  )
  assert(
    not FIG[2] or cmp(ver, FIG[2]) <= 0,
    ("Your Figura version (%s) is above the maximum of %s"):format(ver, FIG[2])
  )
end

--|==================================================================================================================|--
--|=====|| SCRIPT ||=================================================================================================|--
--||=:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:=:==:=:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:=||--

-- Localize Lua basic
local getmetatable = getmetatable
local setmetatable = setmetatable
local type = type
local assert = assert
local error = error
local ipairs = ipairs
local pairs = pairs
local rawset = rawset
-- Localize Lua math
local m_abs = math.abs
local m_map = math.map
local m_max = math.max
local m_huge = math.huge
-- Localize Figura globals
local animations = animations

---@diagnostic disable: duplicate-set-field, duplicate-doc-field

---This library is used to allow prewrite-like animation blending with one new feature with infinite
---possibility added on top.  
---Any fields, functions, and methods injected by this library will be prefixed with
---**[GS AnimBlend Library]** in their description
---
---If this library is required without being stored to a variable, it will automatically set up the
---blending features.  
---If this library is required *and* stored to a variable, it will also contain tools for generating
---pre-built blending callbacks and creating custom blending callbacks.
---```lua
---require "···"
---local anim_blend = require "···"
---```
---@class Lib.GS.AnimBlend
---This library's perferred ID.
---@field _ID string
---This library's version.
---@field _VERSION string
local this = {
  ---Enables error checking in the library. `true` by default.
  ---
  ---Turning off error checking will greatly reduce the amount of instructions used by this library
  ---at the cost of not telling you when you put in a wrong value.
  ---
  ---If an error pops up while this is `false`, try setting it to `true` and see if a different
  ---error pops up.
  safe = true
}
local thismt = {
  __type = ID,
  __metatable = false,
  __index = {
    _ID = ID,
    _VERSION = VER
  }
}

-- Create private space for blending trigger.
-- This is done non-destructively so other scripts may do this as well.
if not getmetatable(_G) then setmetatable(_G, {}) end


-----======================================= VARIABLES ========================================-----

local _GMT = getmetatable(_G)

---Contains the data required to make animation blending for each animation.
---@type {[Animation]: Lib.GS.AnimBlend.AnimData}
local animData = {}

---Contains the currently blending animations.
---@type {[Animation]?: true}
local blending = {}

this.animData = animData
this.blending = blending


-----=================================== UTILITY FUNCTIONS ====================================-----

local chk = {}

chk.types = {
  ["nil"] = "nil",
  boolean = "boolean",
  number = "number",
  string = "string",
  table = "table",
  ["function"] = "function"
}

function chk.badarg(i, name, got, exp, opt)
  local gotT = type(got)
  local gotType = chk.types[gotT] or "userdata"
  if opt and gotType == "nil" then return true end

  local expType = chk.types[exp] or "userdata"
  if gotType ~= expType then
    return false, ("bad argument #%d to '%s' (%s expected, got %s)")
      :format(i, name, expType, gotType)
  elseif expType ~= exp and gotT ~= exp then
    return false, ("bad argument #%d to '%s' (%s expected, got %s)")
      :format(i, name, exp, gotType)
  end

  return true
end

function chk.badnum(i, name, got)
  if type(got) ~= "number" then
    local gotType = chk.types[type(got)] or "userdata"
    return false, ("bad argument #%d to '%s' (number expected, got %s)"):format(i, name, gotType)
  elseif got ~= got or m_abs(got) == m_huge then
    return false, ("bad argument #%d to '%s' (value cannot be %s)"):format(i, name, got)
  end

  return true
end

local function makeSane(val, def)
  return (val == val and m_abs(val) ~= m_huge) and val or def
end


-----=================================== PREPARE ANIMATIONS ===================================-----

-- This will at least catch players running at around 30 fps.
-- Any lower and their computer is already having trouble, they don't need the blending.
local tPass = 0.037504655

local blendCommand = [[getmetatable(_G).GSLib_triggerBlend(%q)]]

_GMT.GSLib_triggerBlend = setmetatable({}, {
  __call = function(self, id)
    if self[id] then self[id]() end
  end
})

local animNum = 0
local function trackAnimation(anim)
  local blend = anim:getBlend()
  local len = anim:getLength()
  local lenSane = makeSane(len, false)
  lenSane = lenSane and (lenSane > tPass and lenSane) or false
  local tID = "blendAnim_" .. animNum

  animData[anim] = {
    blendTime = 0,
    blend = blend,
    blendSane = makeSane(blend, 0),
    length = lenSane,
    triggerId = tID,
    callback = nil
  }

  _GMT.GSLib_triggerBlend[tID] = function() if anim:getLoop() == "ONCE" then anim:stop() end end

  if lenSane then
    if anim.newCode then
      anim:newCode(m_max(lenSane - tPass, 0), blendCommand:format(tID))
    else
      anim:addCode(m_max(lenSane - tPass, 0), blendCommand:format(tID))
    end
  end

  animNum = animNum + 1
end

---@compat <=rc.12
if type(animations) == "table" then
  for _, model in pairs(animations) do
    for _, anim in pairs(model) do trackAnimation(anim) end
  end
else -- rc13
  for _, anim in ipairs(animations:getAnimations()) do trackAnimation(anim) end
end


-----============================ PREPARE METATABLE MODIFICATIONS =============================-----

local mt = figuraMetatables.Animation

local ext_Animation = next(animData)
if not ext_Animation then error(
  "No animations have been found!\n" ..
  "This library cannot build its functions without an animation to use.\n" ..
  "Create an animation or don't `require` this library to fix the error."
) end


-- Check for conflicts
if ext_Animation.blendTime then
  local path = tostring(ext_Animation.blendTime):match("^function: (.-):%d+%-%d+$")
  error("Conflicting script [" .. path .. "] found!")
end

local _animationIndex = mt.__index
local _animationNewIndex = mt.__newindex or rawset

local animPlay = ext_Animation.play
local animStop = ext_Animation.stop
local animBlend = ext_Animation.blend
local animLength = ext_Animation.length
local animGetPlayState = ext_Animation.getPlayState
local animGetBlend = ext_Animation.getBlend
local animIsPlaying = ext_Animation.isPlaying
local animIsPaused = ext_Animation.isPaused
---@diagnostic disable-next-line: undefined-field
local animNewCode = ext_Animation.newCode or ext_Animation.addCode

---Contains the old functions, just in case you need direct access to them again.
---
---These are useful for creating your own blending callbacks.
this.oldF = {
  play = animPlay,
  stop = animStop,

  getBlend = animGetBlend,
  getPlayState = animGetPlayState,
  isPlaying = animIsPlaying,
  isPaused = animIsPaused,

  setBlend = ext_Animation.setBlend,
  setLength = ext_Animation.setLength,
  setPlaying = ext_Animation.setPlaying,

  blend = animBlend,
  length = animLength,
  playing = ext_Animation.playing
}


-----===================================== SET UP LIBRARY =====================================-----

---Causes a blending event to happen.
---
---If `time`, `from`, or `to` are `nil`, they will take from the animation's data to determine this
---value.
---
---One of `from` or `to` *must* be set.
---
---If `starting` is given, it will be used instead of the guessed value from the data given.
---@param anim Animation
---@param time? number
---@param from? number
---@param to? number
---@param starting? boolean
---@return Lib.GS.AnimBlend.BlendState
function this.blend(anim, time, from, to, starting)
  if this.safe then
    assert(chk.badarg(1, "blend", anim, "Animation"))
    assert(chk.badarg(2, "blend", time, "number", true))
    assert(chk.badarg(3, "blend", from, "number", true))
    assert(chk.badarg(4, "blend", to, "number", true))
    if not from and not to then error("one of arguments #3 or #4 must be a number", 2) end
  end

  local data = animData[anim]

  if starting == nil then
    local _from, _to = from or data.blendSane, to or data.blendSane
    starting = _from < _to
  end

  ---@type Lib.GS.AnimBlend.BlendState
  local blendState = {
    time = 0,
    max = time or false,

    from = from or false,
    to = to or false,

    callback = data.callback or this.defaultCallback,

    starting = starting
  }

  local blendSane = data.blendSane

  blendState.callbackState = {
    anim = anim,
    time = 0,
    max = time or data.blendTime,
    progress = 0,
    from = from or blendSane,
    to = to or blendSane,
    starting = starting,
    done = false
  }

  data.state = blendState

  blending[anim] = true

  animBlend(anim, from or blendSane)
  animPlay(anim)
  anim:pause()

  return blendState
end


-----==================================== PRESET CALLBACKS ====================================-----

---Contains blending callback generators.
---
---These are *not* callbacks themselves. They are meant to be called to generate a callback which
---can *then* be used.
local callbackGenerators = {}

---The default callback used by this library. This is used when no other callback is being used.
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function this.defaultCallback(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    animBlend(state.anim, m_map(state.time, 0, state.max, state.from, state.to))
  end
end

---Given a list of parts, this will generate a blending callback that will blend between the vanilla
---parts' normal rotations and the rotations of the animation.
---
---The list of parts given is expected to the the list of parts that have a vanilla parent type in
---the chosen animation in no particular order.
---
---This callback *also* expects the animation to override vanilla rotations.
---
---Note: The resulting callback makes *heavy* use of `:offsetRot()` and will conflict with any other
---code that also uses that method!
---@param parts ModelPart[]
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.blendVanilla(parts)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if parts.done ~= nil then
    error("attempt to use generator 'blendVanilla' as a blend callback.", 2)
  end

  ---@type {[string]: ModelPart[]}
  local partList = {}

  -- Gather the vanilla parent of each part.
  for _, part in ipairs(parts) do
    local vpart = part:getParentType():gsub("([a-z])([A-Z])", "$1_$2"):upper()
    if vanilla_model[vpart] then
      if not partList[vpart] then partList[vpart] = {} end
      local plvp = partList[vpart]
      plvp[#plvp+1] = part
    end
  end

  -- The actual callback is created here.
  return function(state, data)
    if state.done then
      (state.starting and animPlay or animStop)(state.anim)
      for _, v in pairs(partList) do
        for _, p in ipairs(v) do p:offsetRot() end
      end
      animBlend(state.anim, data.blend)
    else
      local pct = state.starting and 1 - state.progress or state.progress

      for n, v in pairs(partList) do
        ---@type Vector3
        local rot = vanilla_model[n]:getOriginRot()
        if n == "HEAD" then rot[2] = ((rot[2] + 180) % 360) - 180 end
        rot:scale(pct)
        for _, p in ipairs(v) do p:offsetRot(rot) end
      end

      animBlend(state.anim, m_map(state.time, 0, state.max, state.from, state.to))
    end
  end
end

---Generates a callback that causes an animation to blend into another animation.
---@param anim Animation
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.blendTo(anim)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if anim.done ~= nil then
    error("attempt to use generator 'blendTo' as a blend callback.", 2)
  end

  ---This is used to track when the next animation should start blending.
  local ready = true

  return function(state, data)
    if state.done then
      (state.starting and animPlay or animStop)(state.anim)
      animBlend(state.anim, data.blend)
      ready = true
    else
      if not state.starting and ready then
        ready = false
        anim:play()
      end
      animBlend(state.anim, m_map(state.time, 0, state.max, state.from, state.to))
    end
  end
end

this.callbackGen = callbackGenerators


-----===================================== BLENDING LOGIC =====================================-----

local ticker = 0
local last_delta = 0
local allowed_contexts = {
  RENDER = true,
  FIRST_PERSON = true
}

events.TICK:register(function()
  ticker = ticker + 1
end, "GSAnimBlend:Tick_TimeTicker")

events.RENDER:register(function(delta, ctx)
  if (ctx and not allowed_contexts[ctx])
  or (delta == last_delta and ticker == 0)
  then return end
  local elapsed_time = ticker + (delta - last_delta)
  ticker = 0
  for anim in pairs(blending) do
    -- Every frame, update time and progress, then call the callback.
    local data = animData[anim]
    local state = data.state
    local cbs = state.callbackState
    state.time = state.time + elapsed_time
    if not state.max then cbs.max = data.blendTime end
    if not state.from then
      cbs.from = data.blendSane
    elseif not state.to then
      cbs.to = data.blendSane
    end

    -- When a blend stops, update all info to signal it has stopped.
    if (state.time >= cbs.max) or (animGetPlayState(anim) == "STOPPED") then
      cbs.time = cbs.max
      cbs.progress = 1
      cbs.done = true

      -- Do final callback.
      state.callback(state.callbackState, animData[anim])
      blending[anim] = nil
    else
      cbs.time = state.time
      cbs.progress = cbs.time / cbs.max
      state.callback(cbs, animData[anim])
    end
  end
  last_delta = delta
end, "GSAnimBlend:Render_UpdateBlendStates")


-----================================ METATABLE MODIFICATIONS =================================-----

---===== FIELDS =====---

local animationGetters = {}
local animationSetters = {}

function animationGetters:blendCallback()
  if this.safe then assert(chk.badarg(1, "__index", self, "Animation")) end
  return animData[self].callback
end
function animationSetters:blendCallback(value)
  if this.safe then
    assert(chk.badarg(1, "__newindex", self, "Animation"))
    assert(chk.badarg(3, "__newindex", value, "function", true))
  end
  animData[self].callback = value
end


---===== METHODS =====---

local animationMethods = {}

function animationMethods:play()
  if this.safe then assert(chk.badarg(1, "play", self, "Animation")) end

  if blending[self] then
    local state = animData[self].state
    if state.starting then return end

    animStop(self)
    local cbs = state.callbackState
    local time = cbs.max * cbs.progress
    this.blend(self, time, animGetBlend(self), nil, true)
    return
  elseif animData[self].blendTime == 0 or animGetPlayState(self) ~= "STOPPED" then
    return animPlay(self)
  end

  this.blend(self, nil, 0, nil, true)
end

--[[
function animationMethods:pause()
  -- Pausing while blending will work eventually.
  -- It's just gonna need some code rework to get done.
end
]]

function animationMethods:stop()
  if this.safe then assert(chk.badarg(1, "stop", self, "Animation")) end

  if blending[self] then
    local state = animData[self].state
    if not state.starting then return end

    local cbs = state.callbackState
    local time = cbs.max * cbs.progress
    this.blend(self, time, animGetBlend(self), 0, false)
    return
  elseif animData[self].blendTime == 0 or animGetPlayState(self) == "STOPPED" then
    return animStop(self)
  end

  this.blend(self, nil, nil, 0, false)
end


---===== GETTERS =====---

function animationMethods:getBlendTime()
  if this.safe then assert(chk.badarg(1, "getBlendTime", self, "Animation")) end
  return animData[self].blendTime
end

function animationMethods:isBlending()
  if this.safe then assert(chk.badarg(1, "isBlending", self, "Animation")) end
  return blending[self]
end

function animationMethods:getBlend()
  if this.safe then assert(chk.badarg(1, "getBlend", self, "Animation")) end
  return animData[self].blend
end

function animationMethods:getPlayState()
  if this.safe then assert(chk.badarg(1, "getPlayState", self, "Animation")) end
  return blending[self] and "PLAYING" or animGetPlayState(self)
end

function animationMethods:isPlaying()
  if this.safe then assert(chk.badarg(1, "isPlaying", self, "Animation")) end
  return blending[self] or animIsPlaying(self)
end

function animationMethods:isPaused()
  if this.safe then assert(chk.badarg(1, "isPaused", self, "Animation")) end
  return not blending[self] and animIsPaused(self)
end


---===== SETTERS =====---

function animationMethods:setBlendTime(time)
  if time == nil then time = 0 end
  if this.safe then
    assert(chk.badarg(1, "setBlendTime", self, "Animation"))
    assert(chk.badnum(2, "setBlendTime", time))
  end

  animData[self].blendTime = m_max(time, 0)
  return self
end

function animationMethods:setOnBlend(func)
  if this.safe then
    assert(chk.badarg(1, "setOnBlend", self, "Animation"))
    assert(chk.badarg(2, "setOnBlend", func, "function", true))
  end

  animData[self].callback = func
  return self
end

function animationMethods:setBlend(weight)
  if weight == nil then weight = 0 end
  if this.safe then
    assert(chk.badarg(1, "setBlend", self, "Animation"))
    assert(chk.badarg(2, "setBlend", weight, "number"))
  end

  local data = animData[self]
  data.blend = weight
  data.blendSane = makeSane(weight, 0)
  return animBlend(self, weight)
end

function animationMethods:setLength(len)
  if len == nil then len = 0 end
  if this.safe then
    assert(chk.badarg(1, "setLength", self, "Animation"))
    assert(chk.badarg(2, "setLength", len, "number"))
  end

  local data = animData[self]
  if data.length then animNewCode(self, data.length, "") end

  local lenSane = makeSane(m_max(len - tPass, 0), false)
  data.length = lenSane and (lenSane > tPass and lenSane) or false

  if data.length then
    animNewCode(self, m_max(data.length - tPass, 0), blendCommand:format(data.triggerId))
  end
  return animLength(self, len)
end

function animationMethods:setPlaying(state)
  if this.safe then assert(chk.badarg(1, "setPlaying", self, "Animation")) end
  if state then self:play() else self:stop() end
  return self
end


---===== CHAINED =====---

animationMethods.blendTime = animationMethods.setBlendTime
animationMethods.onBlend = animationMethods.setOnBlend
animationMethods.blend = animationMethods.setBlend
animationMethods.length = animationMethods.setLength
animationMethods.playing = animationMethods.setPlaying


function mt:__index(key)
  if animationGetters[key] then
    return animationGetters[key](self)
  elseif animationMethods[key] then
    return animationMethods[key]
  else
    return _animationIndex(self, key)
  end
end

function mt:__newindex(key, value)
  if animationSetters[key] then
    animationSetters[key](self, value)
    return
  else
    _animationNewIndex(self, key, value)
  end
end


do return setmetatable(this, thismt) end


--|==================================================================================================================|--
--|=====|| DOCUMENTATION ||==========================================================================================|--
--||=:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:=:==:=:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:==:=||--

---@diagnostic disable: duplicate-set-field, duplicate-doc-field, duplicate-doc-alias
---@diagnostic disable: missing-return, unused-local, lowercase-global

---@class Lib.GS.AnimBlend.AnimData
---The blending time of this animation in ticks.
---@field blendTime number
---The faked blend weight value of this animation.
---@field blend number
---The preferred blend weight that blending will use.
---@field blendSane number
---Where in the timeline the stop instruction is placed.  
---If this is `false`, there is no stop instruction due to length limits.
---@field length number|false
---The id for this animation's blend trigger
---@field triggerId string
---The callback function this animation will call every frame while it is blending and one final
---time when blending finishes.
---@field callback? Lib.GS.AnimBlend.blendCallback
---The active blend state.
---@field state? Lib.GS.AnimBlend.BlendState

---@class Lib.GS.AnimBlend.BlendState
---The amount of time this blend has been running for in ticks.
---@field time number
---The maximum time this blend will run in ticks.
---@field max number|false
---The starting blend weight.
---@field from number|false
---The ending blend weight.
---@field to number|false
---The callback to call each blending frame.
---@field callback? function
---The state proxy used in the blend callback function.
---@field callbackState Lib.GS.AnimBlend.CallbackState
---Determines if this blend is starting or ending an animation.
---@field starting boolean

---@class Lib.GS.AnimBlend.CallbackState
---The animation this callback is acting on.
---@field anim Animation
---The amount of time this blend has been running for in ticks.
---@field time number
---The maximum time this blend will run in ticks.
---@field max number
---The progress as a percentage.
---@field progress number
---The starting blend weight.
---@field from number
---The ending blend weight.
---@field to number
---Determines if this blend is starting or ending an animation.
---@field starting boolean
---Determines if this blend is finishing up.
---@field done boolean

---@alias Lib.GS.AnimBlend.blendCallback
---| fun(state: Lib.GS.AnimBlend.CallbackState, data: Lib.GS.AnimBlend.AnimData)





---@class Animation
---#### [GS AnimBlend Library]
---The callback that should be called every frame while the animation is blending.
---
---This allows adding custom behavior to the blending feature.
---
---If this is `nil`, it will default to the library's basic callback.
---@field blendCallback? Lib.GS.AnimBlend.blendCallback
local Animation


---===== GETTERS =====---

---#### [GS AnimBlend Library]
---Gets the blending time of this animation in ticks.
---@return number
function Animation:getBlendTime() end

---#### [GS AnimBlend Library]
---Gets if this animation is currently blending.
---@return boolean
function Animation:isBlending() end


---===== SETTERS =====---

---#### [GS AnimBlend Library]
---Sets the blending time of this animation in ticks.
---@generic self
---@param self self
---@param time number
---@return self
function Animation:setBlendTime(time) end

---#### [GS AnimBlend Library]
---Sets the blending callback of this animation.
---@generic self
---@param self self
---@param func? Lib.GS.AnimBlend.blendCallback
---@return self
function Animation:setOnBlend(func) end


---===== CHAINED =====---

---#### [GS AnimBlend Library]
---Sets the blending time of this animation in ticks.
---@generic self
---@param self self
---@param time number
---@return self
function Animation:blendTime(time) end

---#### [GS AnimBlend Library]
---Sets the blending callback of this animation.
---@generic self
---@param self self
---@param func? Lib.GS.AnimBlend.blendCallback
---@return self
function Animation:onBlend(func) end

