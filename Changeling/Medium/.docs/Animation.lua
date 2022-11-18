---@diagnostic disable: duplicate-set-field
---A blockbench animation.
---@class Animation
---@field name string This animation's name.
local Animation={}
---Sets the animation's priority. Instead of blending, low priority animations are overridden by high priority ones.
---@param priority integer
---@return Animation
function Animation:priority(priority) end
---Set the animation's length, in seconds.
---@param length number
---@return Animation
function Animation:length(length) end
---Gets the animation's length.
---@return number
function Animation:getLength() end
---Sets the animation's keyframe blend factor.
---@param blend number
---@return Animation
function Animation:blend(blend) end
---Sets how much time to skip for the animation. The time is skipped on every loop.
---@param offset number
---@return Animation
function Animation:offset(offset) end
---Gets the animation's priority.
---@return integer
function Animation:getPriority() end
---Stop the animation.
---@return nil
function Animation:stop() end
---Set if this animation should override its part transforms.
---@param override boolean
---@return Animation
function Animation:override(override) end
---Sets the animation's loop mode.
---@param loop LoopModes
---@return Animation
function Animation:loop(loop) end
---Gets the animation's offset time.
---@return number
function Animation:getOffset() end
---Get the animation's playback current time.
---@return number
function Animation:getTime() end
---Sets the animation's playback current time.
---@param time number
---@return nil
function Animation:setTime(time) end
---Initializes the animation. Resume the animation if it was paused.
---@return nil
function Animation:play() end
---Sets the animation's playback speed. Negative numbers can be used for an inverted animation.
---@param speed number
---@return Animation
function Animation:speed(speed) end
---Set how much time to wait in between the loops of this animation.
---@param delay number
---@return Animation
function Animation:loopDelay(delay) end
---Set how much time to wait before this animation is initialized. Note that while it is waiting, the animation is considered being played.
---@param delay number
---@return Animation
function Animation:startDelay(delay) end
---Restarts the animation. Plays the animation if it was stopped. This behaviour can also be reproduced by stopping then playing the animation
---@return nil
function Animation:restart() end
---Adds a string to run in a determinant time. If theres already code to run at that time, it is overridden.
---@param time number
---@param code string
---@return Animation
function Animation:addCode(time, code) end
---Get the animation's playback state.
---@return PlayStates
function Animation:getPlayState() end
---Gets the animation's start delay.
---@return number
function Animation:getStartDelay() end
---Gets the animation's loop delay.
---@return number
function Animation:getLoopDelay() end
---Gets the animation's keyframe blend factor.
---@return number
function Animation:getBlend() end
---Gets the animation's override status.
---@return boolean
function Animation:getOverride() end
---Gets the animation's loop mode.
---@return LoopModes
function Animation:getLoop() end
---Gets the animation's speed.
---@return number
function Animation:getSpeed() end
---Pause the animation's playback.
---@return nil
function Animation:pause() end
