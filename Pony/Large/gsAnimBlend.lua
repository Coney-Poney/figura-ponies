-- ┌───┐                ┌───┐ --
-- │ ┌─┘ ┌─────┐┌─────┐ └─┐ │ --
-- │ │   │ ┌───┘│ ╶───┤   │ │ --
-- │ │   │ ├───┐└───┐ │   │ │ --
-- │ │   │ └─╴ │┌───┘ │   │ │ --
-- │ └─┐ └─────┘└─────┘ ┌─┘ │ --
-- └───┘                └───┘ --
---@module  "Animation Blend Library" <GSAnimBlend>
---@version v1.7.2
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
local VER = "1.7.2"
local FIG = {"0.1.0-rc.9", "0.1.0"}

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
local next = next
local ipairs = ipairs
local pairs = pairs
local rawset = rawset
local tostring = tostring
-- Localize Lua math
local m_abs = math.abs
local m_cos = math.cos
local m_lerp = math.lerp
local m_map = math.map
local m_max = math.max
local m_sin = math.sin
local m_sqrt = math.sqrt
local m_huge = math.huge
local m_pi = math.pi
-- Localize Figura globals
local animations = animations
local figuraMetatables = figuraMetatables
local vanilla_model = vanilla_model
local events = events
local _ENV = _ENV --[[@as _G]]

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
if not getmetatable(_ENV) then setmetatable(_ENV, {}) end


-----======================================= VARIABLES ========================================-----

local _ENVMT = getmetatable(_ENV)

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
    if expType == "function" and gotType == "table" then
      local mt = getmetatable(got)
      if mt and mt.__call then return true end
    end
    return false, ("bad argument #%s to '%s' (%s expected, got %s)")
      :format(i, name, expType, gotType)
  elseif expType ~= exp and gotT ~= exp then
    return false, ("bad argument #%s to '%s' (%s expected, got %s)")
      :format(i, name, exp, gotType)
  end

  return true
end

function chk.badnum(i, name, got)
  if type(got) ~= "number" then
    local gotType = chk.types[type(got)] or "userdata"
    return false, ("bad argument #%s to '%s' (number expected, got %s)"):format(i, name, gotType)
  elseif got ~= got or m_abs(got) == m_huge then
    return false, ("bad argument #%s to '%s' (value cannot be %s)"):format(i, name, got)
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

local blendCommand = [[getmetatable(_ENV).GSLib_triggerBlend(%q)]]

_ENVMT.GSLib_triggerBlend = setmetatable({}, {
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

  _ENVMT.GSLib_triggerBlend[tID] = function() if anim:getLoop() == "ONCE" then anim:stop() end end

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

local animation_mt = figuraMetatables.Animation

local ext_Animation = next(animData)
if not ext_Animation then
  error(
    "No animations have been found!\n" ..
    "This library cannot build its functions without an animation to use.\n" ..
    "Create an animation or don't `require` this library to fix the error."
  )
end


-- Check for conflicts
if ext_Animation.blendTime then
  local path = tostring(ext_Animation.blendTime):match("^function: (.-):%d+%-%d+$")
  error(
    "Conflicting script [" .. path .. "] found!\n" ..
    "Remove the other script or this script to fix the error."
  )
end

local _animationIndex = animation_mt.__index
local _animationNewIndex = animation_mt.__newindex or rawset

local animPlay = ext_Animation.play
local animStop = ext_Animation.stop
local animPause = ext_Animation.pause
local animRestart = ext_Animation.restart
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
  pause = animPause,
  restart = animRestart,

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

    paused = false,
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
  animPause(anim)

  return blendState
end


-----==================================== PRESET CALLBACKS ====================================-----

---Contains blending callback generators.
---
---These are *not* callbacks themselves. They are meant to be called to generate a callback which
---can *then* be used.
local callbackGenerators = {}

---Contains custom blending curves.
---
---These callbacks change the curve used when blending. These cannot be used to modify custom or
---generated callbacks (yet).
local callbackCurves = {}


---===== CALLBACK GENERATORS =====---

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
    local vpart = part:getParentType():gsub("([a-z])([A-Z])", "%1_%2"):upper()
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

      animBlend(state.anim, m_lerp(state.from, state.to, state.progress))
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
      animBlend(state.anim, m_lerp(state.from, state.to, state.progress))
    end
  end
end

---Generates a callback that forces all given animations to blend out if they are playing.
---@param anims Animation[]
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.blendOut(anims)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if anim.done ~= nil then
    error("attempt to use generator 'blendOut' as a blend callback.", 2)
  end

  local ready = true

  return function(state, data)
    if state.done then
      (state.starting and animPlay or animStop)(state.anim)
      animBlend(state.anim, data.blend)
      ready = true
    else
      if state.starting and ready then
        ready = false
        for _, anim in ipairs(anims) do anim:stop() end
      end
      animBlend(state.anim, m_lerp(state.from, state.to, state.progress))
    end
  end
end

---Generates a makeshift blending callback by using the return value of the given function as the progress.
---
---The current progress is passed into the function.
---@param func fun(progress: number): number
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.custom(func)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if type(func) == "table" and func.done ~= nil then
    error("attempt to use generator 'custom' as a blend callback.", 2)
  end

  return function(state, data)
    if state.done then
      (state.starting and animPlay or animStop)(state.anim)
      animBlend(state.anim, data.blend)
    else
      animBlend(state.anim, m_lerp(state.from, state.to, func(state.progress)))
    end
  end
end

---@type Lib.GS.AnimBlend.blendCallback
local function instantCallback(state, data)
  state.time = state.max
  state.progress = 1
  state.done = true
  (state.starting and animPlay or animStop)(state.anim)
  animBlend(state.anim, data.blend)
  blending[state.anim] = nil
end

---Generates a callback that plays one callback while blending in and another callback while blending out.
---
---If a string is given instead of a callback, it is treated as the name of a curve found in
---`<GSAnimBlend>.callbackCurves`.  
---If `false` is given, blending will not be done at all. (As if `blendTime` was `0`.)  
---If `nil` is given, the default callback is used.
---@param blend_in? Lib.GS.AnimBlend.blendCallback | Lib.GS.AnimBlend.curve | false
---@param blend_out? Lib.GS.AnimBlend.blendCallback | Lib.GS.AnimBlend.curve | false
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.dualBlend(blend_in, blend_out)
  local tbin, tbout = type(blend_in), type(blend_out)
  local infunc, outfunc = blend_in, blend_out
  if tbin == "string" then
    infunc = callbackCurves[blend_in]
    if not infunc then error("bad argument #1 to 'dualBlend' ('" .. blend_in .. "' is not a valid curve)", 2) end
  elseif blend_in == nil then
    infunc = this.defaultCallback
  elseif blend_in == false then
    infunc = instantCallback
  elseif tbin == "table" then
    -- Because some dumbass won't read the instructions...
    ---@diagnostic disable-next-line: undefined-field
    if blend_in.done ~= nil then
      error("attempt to use generator 'dualBlend' as a blend callback.", 2)
    end
    local mt = getmetatable(blend_in)
    if not (mt and mt.__call) then
      error("bad argument #1 to 'dualBlend' (function or string expected, got " .. tbin .. ")")
    end
  elseif tbin ~= "function" then
    error("bad argument #1 to 'dualBlend' (function or string expected, got " .. tbin .. ")")
  end

  if tbout == "string" then
    outfunc = callbackCurves[blend_out]
    if not outfunc then error("bad argument #2 to 'dualBlend' ('" .. blend_in .. "' is not a valid curve)", 2) end
  elseif blend_out == nil then
    outfunc = this.defaultCallback
  elseif blend_out == false then
    outfunc = instantCallback
  elseif tbout == "table" then
    local mt = getmetatable(blend_out)
    if not (mt and mt.__call) then
      error("bad argument #2 to 'dualBlend' (function or string expected, got " .. tbin .. ")")
    end
  elseif tbout ~= "function" then
    error("bad argument #2 to 'dualBlend' (function or string expected, got " .. tbout .. ")")
  end

  return function(state, data)
    if state.starting then
      infunc(state, data)
    else
      outfunc(state, data)
    end
  end
end

do ---@source https://github.com/gre/bezier-easing/blob/master/src/index.js

  -- Bezier curves are extremely expensive to use especially with higher settings.
  -- Every function has been in-lined to improve instruction counts as much as possible.
  --
  -- In-lined functions are labeled with a --[[funcName(param1, paramN, ...)]]
  -- If an in-lined function spans more than one line, it will contain a #marker# that will appear later to close the
  -- function.
  --
  -- All of the functions below in the block comment are in-lined somewhere else.

  local default_subdiv_iters = 10
  local default_subdiv_prec = 0.0000001
  local default_newton_minslope = 0.001
  local default_newton_iters = 4
  local default_sample_size = 11

  --[=[
  local function _A(A1, A2) return 1.0 - 3.0 * A2 + 3.0 * A1 end
  local function _B(A1, A2) return 3.0 * A2 - 6.0 * A1 end
  local function _C(A1) return 3.0 * A1 end

  -- Returns x(t) given t, x1, and x2, or y(t) given t, y1, and y2.
  local function calcBezier(T, A1, A2)
    --[[((_A(A1, A2) * T + _B(A1, A2)) * T + _C(A1)) * T]]
    return (((1.0 - 3.0 * A2 + 3.0 * A1) * T + (3.0 * A2 - 6.0 * A1)) * T + (3.0 * A1)) * T
  end

  -- Returns dx/dt given t, x1, and x2, or dy/dt given t, y1, and y2.
  local function getSlope(T, A1, A2)
    --[[3.0 * _A(A1, A2) * T ^ 2 + 2.0 * _B(A1, A2) * T + _C(A1)]]
    return 3.0 * (1.0 - 3.0 * A2 + 3.0 * A1) * T ^ 2 + 2.0 * (3.0 * A2 - 6.0 * A1) * T + (3.0 * A1)
  end

  local function binarySubdivide(X, A, B, X1, X2)
    local curX, curT
    local iter = 0
    while (m_abs(curX) > SUBDIVISION_PRECISION and iter < SUBDIVISION_MAX_ITERATIONS) do
      curT = A + (B - A) * 0.5
      --[[calcBezier(curT, X1, X2) - X]]
      curX = ((((1.0 - 3.0 * X2 + 3.0 * X1) * curT + (3.0 * X2 - 6.0 * X1)) * curT + (3.0 * X1)) * curT) - X
      if curX > 0.0 then B = curT else A = curT end
      iter = iter + 1
    end
    return curT or (A + (B - A) * 0.5)
  end

  local function newtonRaphsonIterate(X, Tguess, X1, X2)
    for _ = 1, NEWTON_ITERATIONS do
      --[[getSlope(Tguess, X1, X2)]]
      local curSlope = 3.0 * (1.0 - 3.0 * X2 + 3.0 * X1) * Tguess ^ 2 + 2.0 * (3.0 * X2 - 6.0 * X1) * Tguess + (3.0 * X1)
      if (curSlope == 0.0) then return Tguess end
      --[[calcBezier(Tguess, X1, X2) - X]]
      local curX = ((((1.0 - 3.0 * X2 + 3.0 * X1) * Tguess + (3.0 * X2 - 6.0 * X1)) * Tguess + (3.0 * X1)) * Tguess) - X
      Tguess = Tguess - (curX / curSlope)
    end
    return Tguess
  end

  local function getTForX(X)
    local intervalStart = 0.0
    local curSample = 1
    local lastSample = SAMPLE_SIZE - 1

    while curSample ~= lastSample and SAMPLES[curSample] <= X do
      intervalStart = intervalStart + STEP_SIZE
      curSample = curSample + 1
    end
    curSample = curSample - 1

    -- Interpolate to provide an initial guess for t
    local dist = (X - SAMPLES[curSample]) / (SAMPLES[curSample + 1] - SAMPLES[curSample])
    local Tguess = intervalStart + dist * STEP_SIZE

    local initSlope = getSlope(Tguess, X1, X2)
    if (initSlope >= NEWTON_MIN_SLOPE) then
      return newtonRaphsonIterate(X, Tguess, X1, X2)
    elseif (initSlope == 0) then
      return Tguess
    else
      return binarySubdivide(X, intervalStart, intervalStart + STEP_SIZE, X1, X2)
    end
  end
  ]=]

  local BezierMT = {
    ---@param self Lib.GS.AnimBlend.Bezier
    __call = function(self, state, data)
      if state.done then
        (state.starting and animPlay or animStop)(state.anim)
        animBlend(state.anim, data.blend)
      else
        local X1, X2 = self[1], self[3]
        local Y1, Y2 = self[2], self[4]
        local X = state.progress
        local T
        --[[getTForX(state.progress) #start getTForX#]]
        local intervalStart = 0
        local curSample = 1
        local lastSample = self.options.sample_size - 1
        local samples = self.samples
        local step_size = samples.step

        while curSample ~= lastSample and samples[curSample] <= X do
          intervalStart = intervalStart + step_size
          curSample = curSample + 1
        end
        curSample = curSample - 1

        -- Interpolate to provide an initial guess for T
        local dist = (X - samples[curSample]) / (samples[curSample + 1] - samples[curSample])
        local Tguess = intervalStart + dist * step_size

        local c1 = (1.0 - 3.0 * X2 + 3.0 * X1)
        local c2 = (3.0 * X2 - 6.0 * X1)
        local c3 = (3.0 * X1)
        --[[getSlope(Tguess, X1, X2)]]
        local initSlope = 3.0 * c1 * Tguess ^ 2 + 2.0 * c2 * Tguess + c3
        if (initSlope >= self.options.newton_minslope) then
          --[[newtonRaphsonIterate(X, Tguess, X1, X2)]]
          for _ = 1, self.options.newton_iters do
            --[[getSlope(Tguess, X1, X2)]]
            local curSlope = 3.0 * c1 * Tguess ^ 2 + 2.0 * c2 * Tguess + c3
            if (curSlope == 0.0) then break end
            --[[calcBezier(Tguess, X1, X2) - X]]
            local curX = (((c1 * Tguess + c2) * Tguess + c3) * Tguess) - X
            Tguess = Tguess - (curX / curSlope)
          end
          T = Tguess
        elseif (initSlope == 0) then
          T = Tguess
        else
          local A = intervalStart
          local B = intervalStart + step_size
          --[[binarySubdivide(X, A, B, X1, X2)]]
          local curX, curT
          local iter = 0
          while (m_abs(curX) > self.options.subdiv_prec and iter < self.options.subdiv_iters) do
            curT = A + (B - A) * 0.5
            --[[calcBezier(curT, X1, X2) - X]]
            curX = ((((1.0 - 3.0 * X2 + 3.0 * X1) * curT + (3.0 * X2 - 6.0 * X1)) * curT + (3.0 * X1)) * curT) - X
            if curX > 0.0 then B = curT else A = curT end
            iter = iter + 1
          end
          T = curT or (A + (B - A) * 0.5)
        end
        --#end getTForX#
        --[[calcBezier(T, Y1, Y2)]]
        local prog = (((1.0 - 3.0 * Y2 + 3.0 * Y1) * T + (3.0 * Y2 - 6.0 * Y1)) * T + (3.0 * Y1)) * T
        animBlend(state.anim, m_lerp(state.from, state.to, prog))
      end
    end,
    __index = {
      wrap = function(self) return function(state, data) self(state, data) end end
    },
    type = "Bezier"
  }


  ---Generates a callback that uses a custom bezier curve to blend.
  ---
  ---These are expensive to run so use them sparingly or use low settings.
  ---@param x1 number
  ---@param y1 number
  ---@param x2 number
  ---@param y2 number
  ---@param options? Lib.GS.AnimBlend.BezierOptions
  ---@return Lib.GS.AnimBlend.blendCallback
  function callbackGenerators.bezierEasing(x1, y1, x2, y2, options)
    -- Because some dumbass won't read the instructions...
    ---@diagnostic disable-next-line: undefined-field
    if type(x1) == "table" and x1.done ~= nil then
      error("attempt to use generator 'bezierEasing' as a blend callback.", 2)
    end

    -- Optimization. This may cause an issue if a Bezier object is expected.
    -- If you actually need a Bezier object then don't make a linear bezier lmao.
    if x1 == y1 and x2 == y2 then return callbackCurves.linear end

    ---===== Verify options =====---
    local to = type(options)
    if to == "nil" then
      options = {
        newton_iters = default_newton_iters,
        newton_minslope = default_newton_minslope,
        subdiv_prec = default_subdiv_prec,
        subdiv_iters = default_subdiv_iters,
        sample_size = default_sample_size
      }
    elseif to ~= "table" then
      error("bad argument #5 to 'bezierEasing' (table expected, got " .. to .. ")")
    else
      local oni = options.newton_iters
      if oni == nil then
        options.newton_iters = default_newton_iters
      else
        assert(chk.badnum('5["newton_iters"]', "bezierEasing", oni))
      end

      local onm = options.newton_minslope
      if onm == nil then
        options.newton_minslope = default_newton_minslope
      else
        assert(chk.badnum('5["newton_minslope"]', "bezierEasing", onm))
      end

      local osp = options.subdiv_prec
      if osp == nil then
        options.subdiv_prec = default_subdiv_prec
      else
        assert(chk.badnum('5["subdiv_prec"]', "bezierEasing", osp))
      end

      local osi = options.subdiv_iters
      if osi == nil then
        options.subdiv_iters = default_subdiv_iters
      else
        assert(chk.badnum('5["subdiv_iters"]', "bezierEasing", osi))
      end

      local oss = options.sample_size
      if oss == nil then
        options.sample_size = default_sample_size
      else
        assert(chk.badnum('5["sample_size"]', "bezierEasing", oss))
      end
    end

    chk.badnum(1, "bezierEasing", x1)
    chk.badnum(2, "bezierEasing", y1)
    chk.badnum(3, "bezierEasing", x2)
    chk.badnum(4, "bezierEasing", y2)

    if x1 > 1 or x1 < 0 then
      error("bad argument #1 to 'bezierEasing' (value out of [0, 1] range)", 2)
    end
    if x2 > 1 or x2 < 0 then
      error("bad argument #3 to 'bezierEasing' (value out of [0, 1] range)", 2)
    end

    local samples = {step = 1 / (options.sample_size - 1)}

    ---@type Lib.GS.AnimBlend.bezierCallback
    local obj = setmetatable({
      x1, y1, x2, y2,
      options = options,
      samples = samples
    }, BezierMT)

    local step = samples.step
    local c1 = (1.0 - 3.0 * x2 + 3.0 * x1)
    local c2 = (3.0 * x2 - 6.0 * x1)
    local c3 = (3.0 * x1)
    for i = 0, options.sample_size - 1 do
      local istep = i * step
      --[[calcBezier(istep, X1, X2)]]
      samples[i] = ((c1 * istep + c2) * istep + c3) * istep
    end

    return obj
  end
end

---Generates a callback that plays other callbacks on a timeline.
---
---An example of a valid timeline:
---```lua
---...timeline({
---  {time = 0, min = 0, max = 1, func = <GSAnimBlend>.callbackCurve.easeInSine},
---  {time = 0.5, min = 1, max = 0.5, func = <GSAnimBlend>.callbackCurve.easeOutCubic},
---  {time = 0.5, min = 0.5, max = 1, func = <GSAnimBlend>.callbackCurve.easeInCubic}
---})
---```
---@param tl Lib.GS.AnimBlend.timeline
---@return Lib.GS.AnimBlend.blendCallback
function callbackGenerators.timeline(tl)
  -- Because some dumbass won't read the instructions...
  ---@diagnostic disable-next-line: undefined-field
  if tl.done ~= nil then
    error("attempt to use generator 'timeline' as a blend callback.", 2)
  end

  if this.safe then
    assert(chk.badarg(1, "timeline", tl, "table"))
    for i, kf in ipairs(tl) do
      assert(chk.badarg("1[" .. i .. "]", "timeline", kf, "table"))
    end
    local time = 0
    local ftime = tl[1].time
    if ftime ~= 0 then error("error in keyframe #1: timeline does not start at 0 (got " .. ftime .. ")") end
    for i, kf in ipairs(tl) do
      assert(chk.badnum('1[" .. i .. "]["time"]', "timeline", kf.time))
      if kf.time <= time then
        error(
          "error in keyframe #" .. i ..
          ": timeline did not move forward (from " .. time .. " to " .. kf.time .. ")", 2
        )
      end

      if kf.min then assert(chk.badnum('1[" .. i .. "]["min"]', "timeline", kf.min)) end
      if kf.max then assert(chk.badnum('1[" .. i .. "]["max"]', "timeline", kf.max)) end

      assert(chk.badarg('1[" .. i .. "]["func"]', "timeline", kf.func, "function"), true)
    end
  end

  return function(state, data)
    if state.done then
      (state.starting and animPlay or animStop)(state.anim)
      animBlend(state.anim, data.blend)
    else
      ---@type Lib.GS.AnimBlend.tlKeyframe, Lib.GS.AnimBlend.tlKeyframe
      local kf, nextkf
      for i, _kf in ipairs(tl) do
        if _kf.time > state.progress then
          if _kf.time < 1 then nextkf = _kf end
          break
        end
        kf = _kf
      end

      local adj_prog = m_map(
        state.progress,
        kf.time, nextkf and nextkf.time or 1,
        kf.min or 0, kf.max or 1
      )

      local newstate = setmetatable(
        {time = state.max * adj_prog, progress = adj_prog},
        {__index = state}
      );
      (kf.func or this.defaultCallback)(newstate, data)
    end
  end
end


---===== CALLBACK CURVES =====---

---A callback that uses the `linear` easing method to blend.
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.linear(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    animBlend(state.anim, m_lerp(state.from, state.to, state.progress))
  end
end

-- I planned to add easeOutIn curves but I'm lazy. I'll do it if people request it.

---A callback that uses the `easeInSine` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInSine)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInSine(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = 1 - m_cos((state.progress * m_pi) * 0.5)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutSine` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutSine)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutSine(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = m_sin((state.progress * m_pi) * 0.5)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutSine` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutSine)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutSine(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = -(m_cos(state.progress * m_pi) - 1) * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInQuad` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInQuad)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInQuad(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = state.progress ^ 2
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutQuad` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutQuad)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutQuad(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = 1 - (1 - state.progress) ^ 2
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutQuad` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutQuad)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutQuad(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x < 0.5
      and 2 * x ^ 2
      or 1 - (-2 * x + 2) ^ 2 * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInCubic` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInCubic)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInCubic(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = state.progress ^ 3
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutCubic` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutCubic)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutCubic(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = 1 - (1 - state.progress) ^ 3
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutCubic` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutCubic)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutCubic(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x < 0.5
      and 4 * x ^ 3
      or 1 - (-2 * x + 2) ^ 3 * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInQuart` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInQuart)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInQuart(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = state.progress ^ 4
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutQuart` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutQuart)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutQuart(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = 1 - (1 - state.progress) ^ 4
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutQuart` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutQuart)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutQuart(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x < 0.5
      and 8 * x ^ 4
      or 1 - (-2 * x + 2) ^ 4 * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInQuint` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInQuint)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInQuint(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = state.progress ^ 5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutQuint` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutQuint)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutQuint(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = 1 - (1 - state.progress) ^ 5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutQuint` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutQuint)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutQuint(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x < 0.5
      and 16 * x ^ 5
      or 1 - (-2 * x + 2) ^ 5 * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInExpo` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInExpo)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInExpo(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x == 0
      and 0
      or 2 ^ (10 * x - 10)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutExpo` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutExpo)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutExpo(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x == 1
      and 1
      or 1 - 2 ^ (-10 * x)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutExpo` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutExpo)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutExpo(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x == 0 and 0
      or x == 1 and 1
      or x < 0.5 and 2 ^ (20 * x - 10) * 0.5
      or (2 - 2 ^ (-20 * x + 10)) * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInCirc` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInCirc)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInCirc(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = 1 - m_sqrt(1 - state.progress ^ 2)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutCirc` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutCirc)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutCirc(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local prog = m_sqrt(1 - (state.progress - 1) ^ 2)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutCirc` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutCirc)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutCirc(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = x < 0.5
      and (1 - m_sqrt(1 - (2 * x) ^ 2)) * 0.5
      or (m_sqrt(1 - (-2 * x + 2) ^ 2) + 1) * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInBack` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInBack)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInBack(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress --[[
    magic c1 <1.70158> = 1.70158
    magic c2 <2.70158> = c1 + 1  ]]
    local prog = 2.70158 * x ^ 3 - 1.70158 * x ^ 2
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutBack` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutBack)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutBack(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress - 1 --[[
    magic c1 <1.70158> = 1.70158
    magic c2 <2.70158> = c1 + 1  ]]
    local prog = 1 + 2.70158 * x ^ 3 + 1.70158 * x ^ 2
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutBack` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutBack)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutBack(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local x2 = 2 * x --[[
    magic c1 <1.70158>   = 1.70158
    magic c2 <2.5949095> = c1 * 1.525
    magic c3 <3.5949095> = c2 + 1     ]]
    local prog = x < 0.5
      and (x2 ^ 2 * (3.5949095 * x2 - 2.5949095)) * 0.5
      or ((x2 - 2) ^ 2 * (3.5949095 * (x2 - 2) + 2.5949095) + 2) * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInElastic` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInElastic)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInElastic(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = (x == 0 or x == 1) and x
      or -(2 ^ (10 * x - 10)) * m_sin((x * 10 - 10.75) * m_pi / 1.5)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutElastic` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutElastic)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutElastic(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = (x == 0 or x == 1) and x
      or 2 ^ (-10 * x) * m_sin((x * 10 - 0.75) * m_pi / 1.5) + 1
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutElastic` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutElastic)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutElastic(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    local prog = (x == 0 or x == 1) and x
      or x < 0.5 and -(2 ^ (20 * x - 10) * m_sin((20 * x - 11.125) * m_pi / 2.25)) * 0.5
      or (2 ^ (-20 * x + 10) * m_sin((20 * x - 11.125) * m_pi / 2.25)) * 0.5 + 1
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInBounce` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInBounce)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInBounce(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = 1 - state.progress --[[
    magic c1 <7.5625> = 7.5625
    magic c2 <2.75>   = 2.75   ]]
    local prog = 1 - (x < 1 / 2.75 and 7.5625 * x ^ 2
      or x < 2 / 2.75 and 7.5625 * (x - 1.5 / 2.75) ^ 2 + 0.75
      or x < 2.5 / 2.75 and 7.5625 * (x - 2.25 / 2.75) ^ 2 + 0.9375
      or 7.5625 * (x - 2.625 / 2.75) ^ 2 + 0.984375)
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeOutBounce` easing method to blend.
---
---[Learn More...](https://easings.net/#easeOutBounce)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeOutBounce(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress --[[
    magic c1 <7.5625> = 7.5625
    magic c2 <2.75>   = 2.75   ]]
    local prog = x < 1 / 2.75 and 7.5625 * x ^ 2
      or x < 2 / 2.75 and 7.5625 * (x - 1.5 / 2.75) ^ 2 + 0.75
      or x < 2.5 / 2.75 and 7.5625 * (x - 2.25 / 2.75) ^ 2 + 0.9375
      or 7.5625 * (x - 2.625 / 2.75) ^ 2 + 0.984375
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end

---A callback that uses the `easeInOutBounce` easing method to blend.
---
---[Learn More...](https://easings.net/#easeInOutBounce)
---@param state Lib.GS.AnimBlend.CallbackState
---@param data Lib.GS.AnimBlend.AnimData
function callbackCurves.easeInOutBounce(state, data)
  if state.done then
    (state.starting and animPlay or animStop)(state.anim)
    animBlend(state.anim, data.blend)
  else
    local x = state.progress
    x = x < 0.5 and 1 - 2 * x or 2 * x - 1
    local s = x < 0.5 and -1 or 1 --[[
    magic c1 <7.5625> = 7.5625
    magic c2 <2.75>   = 2.75   ]]
    -- What the fuck.
    local prog = (1 + s * (x < 1 / 2.75 and 7.5625 * x ^ 2
      or x < 2 / 2.75 and 7.5625 * (x - 1.5 / 2.75) ^ 2 + 0.75
      or x < 2.5 / 2.75 and 7.5625 * (x - 2.25 / 2.75) ^ 2 + 0.9375
      or 7.5625 * (x - 2.625 / 2.75) ^ 2 + 0.984375)) * 0.5
    animBlend(state.anim, m_lerp(state.from, state.to, prog))
  end
end


---The default callback used by this library. This is used when no other callback is being used.
this.defaultCallback = callbackCurves["lin" .. "ear"] --Yes, I did this to trick the LuaLS
this.callbackGen = callbackGenerators
this.callbackCurve = callbackCurves


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
  if (ctx and not allowed_contexts[ctx]) or (delta == last_delta and ticker == 0) then return end
  local elapsed_time = ticker + (delta - last_delta)
  ticker = 0
  for anim in pairs(blending) do
    -- Every frame, update time and progress, then call the callback.
    local data = animData[anim]
    local state = data.state
    if not state.paused then
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
        state.callback(cbs, animData[anim])
        blending[anim] = nil
      else
        cbs.time = state.time
        cbs.progress = cbs.time / cbs.max
        state.callback(cbs, animData[anim])
      end
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
    if type(value) ~= "string" then
      assert(chk.badarg(3, "__newindex", value, "function", true))
    end
  end

  if type(func) == "string" then
    value = callbackCurves[value]
    if not value then error("bad argument #3 of '__newindex' ('" .. func .. "' is not a valid curve)") end
  end
  animData[self].callback = value
end


---===== METHODS =====---

local animationMethods = {}

function animationMethods:play()
  if this.safe then assert(chk.badarg(1, "play", self, "Animation")) end

  if blending[self] then
    local state = animData[self].state
    if state.paused then
      state.paused = false
      return
    elseif state.starting then
      return
    end

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

function animationMethods:pause()
  if this.safe then assert(chk.badarg(1, "pause", self, "Animation")) end

  if blending[self] then
    animData[self].state.paused = true
    return
  end

  animPause(self)
end

function animationMethods:restart(blend)
  if this.safe then assert(chk.badarg(1, "restart", self, "Animation")) end

  if blend then
    animStop(self)
    this.blend(self, nil, 0, nil, true)
  elseif blending[self] then
    animBlend(self, animData[self].blend)
    blending[self] = nil
  else
    animRestart(self)
  end
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
  return blending[self]
    and (animData[self].state.paused
      and "PAUSED"
      or "PLAYING")
    or animGetPlayState(self)
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
    if type(func) ~= "string" then
      assert(chk.badarg(2, "setOnBlend", func, "function", true))
    end
  end

  if type(func) == "string" then
    func = callbackCurves[func]
    if not func then error("bad argument #2 of 'setOnBlend' ('" .. func .. "' is not a valid curve)") end
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
  return blending[self] and self or animBlend(self, weight)
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


function animation_mt:__index(key)
  if animationGetters[key] then
    return animationGetters[key](self)
  elseif animationMethods[key] then
    return animationMethods[key]
  else
    return _animationIndex(self, key)
  end
end

function animation_mt:__newindex(key, value)
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
---Determines if this blend is paused.
---@field paused boolean
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

---@class Lib.GS.AnimBlend.BezierOptions
---How many time to use the Newton-Raphson method to approximate.  
---Higher numbers create more accurate approximations at the cost of instructions.
---
---The default value is `4`.
---@field newton_iters? integer
---The minimum slope required to attempt to use the Newton-Raphson method.  
---Lower numbers cause smaller slopes to be approximated at the cost of instructions.
---
---The default value is `0.001`.
---@field newton_minslope? number
---The most precision that subdivision will allow before stopping early.  
---Lower numbers cause subdivision to allow more precision at the cost of instructions.
---
---The default value is `0.0000001`.
---@field subdiv_prec? number
---The maximum amount of times that subdivision will be performed.  
---Higher numbers cause more subdivision to happen at the cost of instructions.
---
---The default value is `10`.
---@field subdiv_iters? integer
---The amount of samples to gather from the bezier curve.  
---Higher numbers gather more samples at the cost of more instructions when creating the curve.  
---Lower numbers gather less samples at the cost of more instructions when blending with the curve.
---
---The default value is `11`.
---@field sample_size? integer

---@class Lib.GS.AnimBlend.Bezier: function
---@overload fun(state: Lib.GS.AnimBlend.CallbackState, data: Lib.GS.AnimBlend.AnimData)
---The X1 value.
---@field [1] number
---The Y1 value.
---@field [2] number
---The X2 value.
---@field [3] number
---The Y2 value.
---@field [4] number
---The options used to make this bezier.
---@field options Lib.GS.AnimBlend.BezierOptions
---The samples gathered from this bezier.
---@field samples {step: number, [integer]: number}

---@class Lib.GS.AnimBlend.tlKeyframe
---The progress this keyframe starts at in the range [0, 1).
---
---If the first keyframe does not start at `0`, an error will be thrown.  
---A keyframe at or after time `1` will never run as completing the blend will be preferred.
---@field time number
---The starting adjusted-progress of this keyframe.  
---Despite the name of this option, it does not need to be smaller than `max`.
---
---All keyframes get an adjusted-progress which starts when the keyframe starts and ends when the next keyframe (or the
---end of the timeline) is hit.
---
---The default value is `0`.
---@field min? number
---The ending adjusted-progress of this keyframe.  
---Despite the name of this option, it does not need to be bigger than `min`.
---
---All keyframes get an adjusted-progress which starts when the keyframe starts and ends when the next keyframe (or the
---end of the timeline) is hit.
---
---The default value is `1`.
---@field max? number
---The blending callback to use for this entire frame.  
---The adjusted-progress is given to this callback as it runs.
---
---If a string is given instead of a callback, it is treated as the name of a curve found in
---`<GSAnimBlend>.callbackCurves`.  
---If `nil` is given, the default callback is used.
---
---Note: Blending callbacks called by this function will **never** call cleanup code. Care should be taken to make sure
---this does not break anything.
---@field func? Lib.GS.AnimBlend.blendCallback | Lib.GS.AnimBlend.curve

---@alias Lib.GS.AnimBlend.blendCallback
---| fun(state: Lib.GS.AnimBlend.CallbackState, data: Lib.GS.AnimBlend.AnimData)

---@alias Lib.GS.AnimBlend.bezierCallback
---| Lib.GS.AnimBlend.Bezier
---| Lib.GS.AnimBlend.blendCallback

---@alias Lib.GS.AnimBlend.timeline Lib.GS.AnimBlend.tlKeyframe[]

---@alias Lib.GS.AnimBlend.curve string
---| "linear"           #
---| "easeInSine"       # [Learn More...](https://easings.net/#easeInSine)
---| "easeOutSine"      # [Learn More...](https://easings.net/#easeOutSine)
---| "easeInOutSine"    # [Learn More...](https://easings.net/#easeInOutSine)
---| "easeInQuad"       # [Learn More...](https://easings.net/#easeInQuad)
---| "easeOutQuad"      # [Learn More...](https://easings.net/#easeOutQuad)
---| "easeInOutQuad"    # [Learn More...](https://easings.net/#easeInOutQuad)
---| "easeInCubic"      # [Learn More...](https://easings.net/#easeInCubic)
---| "easeOutCubic"     # [Learn More...](https://easings.net/#easeOutCubic)
---| "easeInOutCubic"   # [Learn More...](https://easings.net/#easeInOutCubic)
---| "easeInQuart"      # [Learn More...](https://easings.net/#easeInQuart)
---| "easeOutQuart"     # [Learn More...](https://easings.net/#easeOutQuart)
---| "easeInOutQuart"   # [Learn More...](https://easings.net/#easeInOutQuart)
---| "easeInQuint"      # [Learn More...](https://easings.net/#easeInQuint)
---| "easeOutQuint"     # [Learn More...](https://easings.net/#easeOutQuint)
---| "easeInOutQuint"   # [Learn More...](https://easings.net/#easeInOutQuint)
---| "easeInExpo"       # [Learn More...](https://easings.net/#easeInExpo)
---| "easeOutExpo"      # [Learn More...](https://easings.net/#easeOutExpo)
---| "easeInOutExpo"    # [Learn More...](https://easings.net/#easeInOutExpo)
---| "easeInCirc"       # [Learn More...](https://easings.net/#easeInCirc)
---| "easeOutCirc"      # [Learn More...](https://easings.net/#easeOutCirc)
---| "easeInOutCirc"    # [Learn More...](https://easings.net/#easeInOutCirc)
---| "easeInBack"       # [Learn More...](https://easings.net/#easeInBack)
---| "easeOutBack"      # [Learn More...](https://easings.net/#easeOutBack)
---| "easeInOutBack"    # [Learn More...](https://easings.net/#easeInOutBack)
---| "easeInElastic"    # [Learn More...](https://easings.net/#easeInElastic)
---| "easeOutElastic"   # [Learn More...](https://easings.net/#easeOutElastic)
---| "easeInOutElastic" # [Learn More...](https://easings.net/#easeInOutElastic)
---| "easeInBounce"     # [Learn More...](https://easings.net/#easeInBounce)
---| "easeOutBounce"    # [Learn More...](https://easings.net/#easeOutBounce)
---| "easeInOutBounce"  # [Learn More...](https://easings.net/#easeInOutBounce)


---@class Animation
---#### [GS AnimBlend Library]
---The callback that should be called every frame while the animation is blending.
---
---This allows adding custom behavior to the blending feature.
---
---If this is `nil`, it will default to the library's basic callback.
---@field blendCallback? Lib.GS.AnimBlend.blendCallback
local Animation


---===== METHODS =====---

---#### [GS AnimBlend Library]
---Starts this animation from the beginning, even if it is currently paused or playing.
---
---If `blend` is set, it will also restart with a blend.
function Animation:restart(blend) end


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

