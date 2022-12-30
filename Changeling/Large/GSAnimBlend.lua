-- ┌───┐                ┌───┐ --
-- │ ┌─┘ ┌─────┐┌─────┐ └─┐ │ --
-- │ │   │ ┌───┘│ ╶───┤   │ │ --
-- │ │   │ ├───┐└───┐ │   │ │ --
-- │ │   │ └─╴ │┌───┘ │   │ │ --
-- │ └─┐ └─────┘└─────┘ ┌─┘ │ --
-- └───┘                └───┘ --
---@module  "Animation Blend Library" <GSAnimBlend>
---@version v1.3.0
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
local VER = "1.3.0"

-----===================================== DOCUMENTATION ======================================-----

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

if false --[[Documentation Only]] then
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
  ---@return integer
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
  ---@param time integer
  ---@return self
  function Animation:blendTime(time) end

  ---#### [GS AnimBlend Library]
  ---Sets the blending callback of this animation.
  ---@generic self
  ---@param self self
  ---@param func? Lib.GS.AnimBlend.blendCallback
  ---@return self
  function Animation:onBlend(func) end
end


-----====================================== SCRIPT START ======================================-----

----@diagnostic disable: undefined-global, undefined-field

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
    _VERSION = VER,
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

---Contains the active blend states of each animation.
---@type {[Animation]: Lib.GS.AnimBlend.BlendState}
local blendData = {}

this.animData = animData
this.blendData = blendData


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
  local expType = chk.types[exp] or "userdata"

  if opt and gotType == "nil" then
    return true
  elseif gotType ~= expType then
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
  elseif got ~= got or math.abs(got) == math.huge then
    return false, ("bad argument #%d to '%s' (value cannot be %s)"):format(i, name, got)
  end

  return true
end

local function makeSane(val, def)
  return (val == val and math.abs(val) ~= math.huge) and val or def
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
for _, m in pairs(animations) do
  for _, a in pairs(m) do
    local blend = a:getBlend()
    local len = a:getLength()
    local lenSane = makeSane(len, false)
    lenSane = lenSane and (lenSane > tPass and lenSane) or false
    local tID = "blendAnim_" .. animNum

    animData[a] = {
      blendTime = 0,
      blend = blend,
      blendSane = makeSane(blend, 0),
      length = lenSane,
      triggerId = tID,
      callback = nil
    }

    _GMT.GSLib_triggerBlend[tID] = function() if a:getLoop() == "ONCE" then a:stop() end end

    if lenSane then
      a:newCode(math.max(lenSane - tPass, 0), blendCommand:format(tID))
    end

    animNum = animNum + 1
  end
end


-----============================ PREPARE METATABLE MODIFICATIONS =============================-----

local mt = figuraMetatables.Animation

---@type Animation
local Animation = setmetatable({}, mt)

local _animationIndex = mt.__index
local _animationNewIndex = mt.__newindex

local animPlay = Animation.play
local animStop = Animation.stop
local animBlend = Animation.blend
local animLength = Animation.length
local animGetPlayState = Animation.getPlayState

---Contains the old functions, just in case you need direct access to them again.
---
---These are useful for creating your own blending callbacks.
this.oldF = {
  play = animPlay,
  stop = animStop,
  getBlend = Animation.getBlend,
  blend = animBlend,
  length = animLength,
  getPlayState = animGetPlayState
}


-----===================================== SET UP LIBRARY =====================================-----

---Causes a blending event to happen.
---
---If `time`, `from`, or `to` are `nil`, they will take from the animation's data to determine this
---value.
---
---One of `from` or `to` *must* be set.
---@param anim Animation
---@param time? number
---@param from? number
---@param to? number
---@return Lib.GS.AnimBlend.BlendState
function this.blend(anim, time, from, to)
  if this.safe then
    assert(chk.badarg(1, "blend", anim, "Animation"))
    assert(chk.badarg(2, "blend", time, "number", true))
    assert(chk.badarg(3, "blend", from, "number", true))
    assert(chk.badarg(4, "blend", to, "number", true))
    if not from and not to then error("one of arguments #3 or #4 must be a number") end
  end

  local starting
  if from and to then
    starting = from < to
  else
    starting = from == 0 and to ~= 0
  end

  local data = animData[anim]

  ---@type Lib.GS.AnimBlend.BlendState
  local blendState = {
    time = 0,
    max = time or false,

    from = from or false,
    to = to or false,

    callback = data.callback or this.defaultCallback,

    starting = starting
  }

  blendState.callbackState = {
    anim = anim,
    time = 0,
    max = blendState.max or data.blendTime,
    progress = 0,
    from = blendState.from or data.blendSane,
    to = blendState.to or data.blendSane,
    starting = starting,
    done = false
  }

  animBlend(anim, from or animData[anim].blendSane)
  animPlay(anim)
  anim:pause()

  blendData[anim] = blendState
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
    animBlend(state.anim, math.map(state.time, 0, state.max, state.from, state.to))
  end
end

---Given a list of parts, this will generate a blending callback that will blend between the vanilla
---parts' normal rotations and the rotations of the animation.
---
---The list of parts given is expected to the the list of parts that have a vanilla parent type in
---the chosen animation in no particular order.
---
---Note: The resulting callback makes *heavy* use of `:offsetRot()` and will conflict with any other
---code that also uses that method!
---@param parts ModelPart[]
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.blendVanilla(parts)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if parts.done then
    error("attempt to use generator 'blendVanilla' as a blend callback.")
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
        local rot = vanilla_model[n]:getOriginRot()
        if n == "HEAD" then rot[2] = ((rot[2] + 180) % 360) - 180 end
        rot:mul(pct, pct, pct)
        for _, p in ipairs(v) do p:offsetRot(rot) end
      end

      animBlend(state.anim, math.map(state.time, 0, state.max, state.from, state.to))
    end
  end
end

---Generates a callback that causes an animation to blend into another animation.
---@param anim Animation
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.blendTo(anim)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if anim.done then
    error("attempt to use generator 'blendTo' as a blend callback.")
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
      animBlend(state.anim, math.map(state.time, 0, state.max, state.from, state.to))
    end
  end
end

this.callbackGen = callbackGenerators


-----===================================== BLENDING LOGIC =====================================-----

local markToDelete = {}
events.TICK:register(function()
  for a, s in pairs(blendData) do
    if not markToDelete[a] then
      --Update general state data every tick.
      local data = animData[a]
      local cbs = s.callbackState
      s.time = s.time + 1
      if not s.max then cbs.max = data.blendTime end
      if not s.from then
        cbs.from = data.blendSane
      elseif not s.to then
        cbs.to = data.blendSane
      end

      --When a blend stops, update all info to signal it has stopped.
      if (s.time >= cbs.max) or (animGetPlayState(a) == "STOPPED") then
        cbs.time = cbs.max
        cbs.progress = 1
        cbs.done = true

        --Mark for deletion.
        markToDelete[#markToDelete+1] = a
        markToDelete[a] = true
      end
    end
  end
end, "GSBlendAnim:Tick_UpdateState")

local allowed_contexts = {
  RENDER = true,
  FIRST_PERSON = true
}

events.RENDER:register(function(delta, ctx)
  if not allowed_contexts[ctx] then return end
  for a, s in pairs(blendData) do
    if not markToDelete[a] then
      --Every frame, update time and progress, then call the callback.
      local cbs = s.callbackState
      cbs.time = s.time + delta
      cbs.progress = cbs.time / cbs.max
      s.callback(cbs, animData[a])
    end
  end
end, "GSBlendAnim:Render_Progress")

events.POST_RENDER:register(function()
  if #markToDelete > 0 then
    for i, a in ipairs(markToDelete) do
      local s = blendData[a]
      s.callback(s.callbackState, animData[a])
      blendData[a] = nil
      markToDelete[i] = nil
      markToDelete[a] = nil
    end
  end
end, "GSBlendAnim:PostRender_Cleanup")


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

  if animData[self].blendTime == 0 or animGetPlayState(self) ~= "STOPPED" then
    animPlay(self)
    return
  end

  if self:isBlending() and blendData[self].starting then return end

  this.blend(self, nil, 0, nil)
end

function animationMethods:stop()
  if this.safe then assert(chk.badarg(1, "stop", self, "Animation")) end

  if animData[self].blendTime == 0 or animGetPlayState(self) == "STOPPED" then
    animStop(self)
    return
  end

  if self:isBlending() and not blendData[self].starting then return end

  this.blend(self, nil, nil, 0)
end


---===== GETTERS =====---

function animationMethods:getBlendTime()
  if this.safe then assert(chk.badarg(1, "getBlendTime", self, "Animation")) end
  return animData[self].blendTime
end

function animationMethods:isBlending()
  if this.safe then assert(chk.badarg(1, "isBlending", self, "Animation")) end
  return not not blendData[self]
end

function animationMethods:getBlend()
  if this.safe then assert(chk.badarg(1, "getBlend", self, "Animation")) end
  return animData[self].blend
end

function animationMethods:getPlayState()
  if this.safe then assert(chk.badarg(1, "getPlayState", self, "Animation")) end
  return blendData[self] and "PLAYING" or animGetPlayState(self)
end


---===== SETTERS =====---

function animationMethods:blendTime(time)
  if time == nil then time = 0 end
  if this.safe then
    assert(chk.badarg(1, "blendTime", self, "Animation"))
    assert(chk.badnum(2, "blendTime", time))
  end

  animData[self].blendTime = math.max(time, 0)
  return self
end

function animationMethods:onBlend(func)
  if this.safe then
    assert(chk.badarg(1, "onBlend", self, "Animation"))
    assert(chk.badarg(2, "onBlend", func, "function", true))
  end

  animData[self].callback = func
  return self
end

function animationMethods:blend(weight)
  if weight == nil then weight = 0 end
  if this.safe then
    assert(chk.badarg(1, "blend", self, "Animation"))
    assert(chk.badarg(2, "blend", weight, "number"))
  end

  local data = animData[self]
  data.blend = weight
  data.blendSane = makeSane(weight, 0)
  return animBlend(self, weight)
end

function animationMethods:length(len)
  if len == nil then len = 0 end
  if this.safe then
    assert(chk.badarg(1, "length", self, "Animation"))
    assert(chk.badarg(2, "length", len, "number"))
  end

  local data = animData[self]
  if data.length then self:newCode(data.length, "") end

  local lenSane = makeSane(math.max(len - tPass, 0), false)
  data.length = lenSane and (lenSane > tPass and lenSane) or false

  if data.length then
    self:newCode(math.max(data.length - tPass, 0), blendCommand:format(data.triggerId))
  end
  return animLength(self, len)
end

function animationMethods:setPlaying(state)
  if this.safe then assert(chk.badarg(1, "setPlaying", self, "Animation")) end
  if state then self:play() else self:stop() end
end


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
    (_animationNewIndex or rawset)(self, key, value)
  end
end

return setmetatable(this, thismt)
