---@diagnostic disable: duplicate-set-field
---Represents a rendering task for Figura to complete each frame. An abstract superclass of ItemTask, BlockTask, and TextTask.
---@class RenderTask
local RenderTask={}
---The scale of the task, relative with its attached part.
---@param scale Vector3
---@return RenderTask
function RenderTask:scale(scale) end
---The scale of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return RenderTask
function RenderTask:scale(x, y, z) end
---Whether or not this task should be rendered.
---@param bool boolean
---@return RenderTask
function RenderTask:enabled(bool) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param pos Vector3
---@return RenderTask
function RenderTask:pos(pos) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param x number
---@param y number
---@param z number
---@return RenderTask
function RenderTask:pos(x, y, z) end
---Checks if this task is enabled.
---@return boolean
function RenderTask:isEnabled() end
---The rotation of the task, relative with its attached part.
---@param rot Vector3
---@return RenderTask
function RenderTask:rot(rot) end
---The rotation of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return RenderTask
function RenderTask:rot(x, y, z) end
---Whether or not this task should be rendered at full bright.
---@param bool boolean
---@return RenderTask
function RenderTask:emissive(bool) end
---Checks if this task is emissive.
---@return boolean
function RenderTask:isEmissive() end
---Gets this task rotation.
---@return Vector3
function RenderTask:getRot() end
---Gets this task position.
---@return Vector3
function RenderTask:getPos() end
---Gets this task scale.
---@return Vector3
function RenderTask:getScale() end
