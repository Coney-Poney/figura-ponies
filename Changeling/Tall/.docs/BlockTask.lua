---@diagnostic disable: duplicate-set-field
---A task for rendering a Block.
---@class BlockTask:RenderTask
local BlockTask={}
---Sets the Block for this task render.
---@param block string
---@return BlockTask
function BlockTask:block(block) end
---Sets the Block for this task render.
---@param block BlockState
---@return BlockTask
function BlockTask:block(block) end
---The scale of the task, relative with its attached part.
---@param scale Vector3
---@return BlockTask
function BlockTask:scale(scale) end
---The scale of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return BlockTask
function BlockTask:scale(x, y, z) end
---Whether or not this task should be rendered.
---@param bool boolean
---@return BlockTask
function BlockTask:enabled(bool) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param pos Vector3
---@return BlockTask
function BlockTask:pos(pos) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param x number
---@param y number
---@param z number
---@return BlockTask
function BlockTask:pos(x, y, z) end
---Checks if this task is enabled.
---@return boolean
function BlockTask:isEnabled() end
---The rotation of the task, relative with its attached part.
---@param rot Vector3
---@return BlockTask
function BlockTask:rot(rot) end
---The rotation of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return BlockTask
function BlockTask:rot(x, y, z) end
---Whether or not this task should be rendered at full bright.
---@param bool boolean
---@return BlockTask
function BlockTask:emissive(bool) end
---Checks if this task is emissive.
---@return boolean
function BlockTask:isEmissive() end
---Gets this task rotation.
---@return Vector3
function BlockTask:getRot() end
---Gets this task position.
---@return Vector3
function BlockTask:getPos() end
---Gets this task scale.
---@return Vector3
function BlockTask:getScale() end
