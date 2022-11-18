---@diagnostic disable: duplicate-set-field
---A task for rendering an Item.
---@class ItemTask:RenderTask
local ItemTask={}
---Sets the Item for this task render.
---@param item string
---@return ItemTask
function ItemTask:item(item) end
---Sets the Item for this task render.
---@param item ItemStack
---@return ItemTask
function ItemTask:item(item) end
---Sets the type of item rendering to use for this task.
---@param renderType ItemRenderTypes
---@return ItemTask
function ItemTask:renderType(renderType) end
---Gets this task item rendering type.
---@return ItemRenderTypes
function ItemTask:getRenderType() end
---The scale of the task, relative with its attached part.
---@param scale Vector3
---@return ItemTask
function ItemTask:scale(scale) end
---The scale of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return ItemTask
function ItemTask:scale(x, y, z) end
---Whether or not this task should be rendered.
---@param bool boolean
---@return ItemTask
function ItemTask:enabled(bool) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param pos Vector3
---@return ItemTask
function ItemTask:pos(pos) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param x number
---@param y number
---@param z number
---@return ItemTask
function ItemTask:pos(x, y, z) end
---Checks if this task is enabled.
---@return boolean
function ItemTask:isEnabled() end
---The rotation of the task, relative with its attached part.
---@param rot Vector3
---@return ItemTask
function ItemTask:rot(rot) end
---The rotation of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return ItemTask
function ItemTask:rot(x, y, z) end
---Whether or not this task should be rendered at full bright.
---@param bool boolean
---@return ItemTask
function ItemTask:emissive(bool) end
---Checks if this task is emissive.
---@return boolean
function ItemTask:isEmissive() end
---Gets this task rotation.
---@return Vector3
function ItemTask:getRot() end
---Gets this task position.
---@return Vector3
function ItemTask:getPos() end
---Gets this task scale.
---@return Vector3
function ItemTask:getScale() end
