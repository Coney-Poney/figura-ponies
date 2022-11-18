---@diagnostic disable: duplicate-set-field
---A proxy for a block state from Minecraft. Instances are obtained through the WorldAPI. This proxy also contains a saved position for the BlockState.
---@class BlockState
---@field id string The identifier of the block this BlockState comes from.
---@field properties table A table containing the properties of this BlockState. If this BlockState has no properties, it is nil.
local BlockState={}
---Gets whether or not this BlockState is opaque.
---@return boolean
function BlockState:isOpaque() end
---Gets the amount of signal strength a comparator would get from this BlockState.
---@return integer
function BlockState:getComparatorOutput() end
---Gets whether or not the BlockState uses emissive lighting.
---@return boolean
function BlockState:hasEmissiveLighting() end
---Returns true if this block has collision.
---@return boolean
function BlockState:hasCollision() end
---Returns the saved position for this BlockState proxy. The saved position is used in BlockState functions that require a position.
---@return Vector3
function BlockState:getPos() end
---Sets the saved position for this BlockState proxy. The saved position is used in BlockState functions that require a position.
---@param pos Vector3
---@return nil
function BlockState:setPos(pos) end
---Sets the saved position for this BlockState proxy. The saved position is used in BlockState functions that require a position.
---@param x number
---@param y number
---@param z number
---@return nil
function BlockState:setPos(x, y, z) end
---Gets the opacity of the BlockState, in terms of how much it affects light levels.
---@return integer
function BlockState:getOpacity() end
---Returns a table containing all the tags of this block, as strings.
---@return string[]
function BlockState:getTags() end
---Gets whether or not the BlockState would propagate sky light downwards.
---@return boolean
function BlockState:isTranslucent() end
---Gets whether or not the BlockState is considered a "solid" block by Minecraft.
---@return boolean
function BlockState:isSolidBlock() end
---Gets whether or not this BlockState emits redstone power.
---@return boolean
function BlockState:emitsRedstonePower() end
---Gets whether or not the BlockState has a full cube as its collision hitbox.
---@return boolean
function BlockState:isFullCube() end
---Gets whether or not this BlockState has an associated block entity.
---@return boolean
function BlockState:hasBlockEntity() end
---Gets the map color of this BlockState, as a Vector3 with R,G,B ranging 0 to 1.
---@return Vector3
function BlockState:getMapColor() end
---Gets the friction of this BlockState. (Slime blocks and ice in vanilla)
---@return number
function BlockState:getFriction() end
---Gets the blast resistance of this BlockState.
---@return number
function BlockState:getBlastResistance() end
---Returns an ItemStack representing this block in item form, whatever Minecraft deems that to be. If it cannot find an item for this block, it will return nil.
---@return ItemStack
function BlockState:asItem() end
---Returns a table representing the bounding boxes of the outline shape. The table a list of Vector6, where the first 3 coordinates are one corner of the box and the last 3 are the other corner.
---@return Vector6[]
function BlockState:getOutlineShape() end
---Converts this BlockState into a string, like you'd see in a Minecraft command.
---@return string
function BlockState:toStateString() end
---Returns a table representing the bounding boxes of the collision shape. The table a list of Vector6, where the first 3 coordinates are one corner of the box and the last 3 are the other corner.
---@return Vector6[]
function BlockState:getCollisionShape() end
---Returns a table containing all the fluid tags of this block, as strings.
---@return string[]
function BlockState:getFluidTags() end
---Returns the nbt of the Block Entity associated with this BlockState, at its position, as a table. Since the mod is only on client side, this NBT might not actually contain the real nbt, which is stored server-side.
---@return string[]
function BlockState:getEntityData() end
---Gets the names of all the sounds which can play from this BlockState, as well as their pitch and volume. Stored in a table.
---@return {pitch:number,volume:number,hit:string,fall:string,plate:string,step:string,break:string}
function BlockState:getSounds() end
---Gets the jump velocity multiplier of this BlockState. (Literally just honey blocks in vanilla)
---@return number
function BlockState:getJumpVelocityMultiplier() end
---Gets the velocity multiplier of this BlockState. (Only Soul sand, honey blocks in vanilla)
---@return number
function BlockState:getVelocityMultiplier() end
---Gets the hardness of the BlockState.
---@return number
function BlockState:getHardness() end
---Gets the emission light level of this BlockState.
---@return integer
function BlockState:getLuminance() end
---Gets the name of the material this block is made of.
---@return string
function BlockState:getMaterial() end
