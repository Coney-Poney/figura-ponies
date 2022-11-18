---@diagnostic disable: duplicate-set-field
---Acts as a proxy for an entity in the Minecraft world.
---@class EntityAPI
local EntityAPI={}
---Gets the name of this entity, if it has a custom name. If it doesn't, returns a translated form of getType().
---@return string
function EntityAPI:getName() end
---Gets the Minecraft identifier of this entity. For instance, "minecraft:pig".
---@return string
function EntityAPI:getType() end
---Checks if this entity object is still being updated and loaded. A non loaded entity would be someone who is in another dimension or out of the render distance for example.
---@return boolean
function EntityAPI:isLoaded() end
---Gets an ItemStack for the item in the given slot. For the player, slots are indexed with 1 as the main hand, 2 as the off hand, and 3,4,5,6 as the 4 armor slots from the boots to the helmet. If an invalid slot number is given, or if the entity has no item in that slot, this will return nil.
---@param index integer
---@return ItemStack
function EntityAPI:getItem(index) end
---Gets a table containing the NBT of this entity. Please note that not all values in the entity's NBT may be synced, as some are handled only on server side.
---@return table
function EntityAPI:getNbt() end
---Gets the maximum amount of air this entity can have.
---@return integer
function EntityAPI:getMaxAir() end
---Gets the current velocity of this entity in world coordinates, calculated as its position this tick minus its position last tick.
---@return Vector3
function EntityAPI:getVelocity() end
---Gets the Minecraft identifier of the dimension this entity is in.
---@return string
function EntityAPI:getDimensionName() end
---Gets the UUID of the proxied entity.
---@return string
function EntityAPI:getUUID() end
---Returns a unit vector pointing in the direction that this entity is looking. See the blue line in the F3+B screen for an example.
---@return Vector3
function EntityAPI:getLookDir() end
---Gets the rotation of the entity in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the entity between the previous tick and the current tick. The default value of delta is 1.
---@return Vector2
function EntityAPI:getRot() end
---Gets the rotation of the entity in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the entity between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return Vector2
function EntityAPI:getRot(delta) end
---Gets the current amount of air this entity has remaining.
---@return integer
function EntityAPI:getAir() end
---Returns whether or not this entity is currently on the ground.
---@return boolean
function EntityAPI:isOnGround() end
---"Refused to elaborate."
---@return boolean
function EntityAPI:isHamburger() end
---Returns the current eye height of this entity.
---@return number
function EntityAPI:getEyeHeight() end
---Gets the number of ticks this entity has been freezing in powder snow for.
---@return integer
function EntityAPI:getFrozenTicks() end
---Returns a proxy for the entity that this player is currently riding. If the player isn't riding anything, returns nil.
---@return EntityAPI
function EntityAPI:getVehicle() end
---Gets the position of the entity in the world. If delta is passed in, then it will be used to linearly interpolate the position of the entity between the previous tick and the current tick. The default value of delta is 1.
---@return Vector3
function EntityAPI:getPos() end
---Gets the position of the entity in the world. If delta is passed in, then it will be used to linearly interpolate the position of the entity between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return Vector3
function EntityAPI:getPos(delta) end
---Returns the remaining number of ticks this entity will be on fire for.
---@return integer
function EntityAPI:getFireTicks() end
---Returns the size of this entity's bounding box as a Vector3. {x, y, z} are the width, height, and width. Minecraft entity hitboxes always have square bases.
---@return Vector3
function EntityAPI:getBoundingBox() end
---Returns the current pose of the player. This can be one of: "STANDING", "FALL_FLYING", "SLEEPING", "SWIMMING", "SPIN_ATTACK", "CROUCHING", "LONG_JUMPING", or "DYING".
---@return EntityPoses
function EntityAPI:getPose() end
---Returns true if this entity is currently in a water block, including waterlogging.
---@return boolean
function EntityAPI:isInWater() end
---Returns true in any of three conditions: if the entity is in water, if the entity is in rain, or if the entity is in a bubble column. Otherwise, returns false.
---@return boolean
function EntityAPI:isWet() end
---Returns the Y level of this entity's eyes. Not to be confused with getEyeHeight, this function also takes the entity itself's Y position into account.
---@return number
function EntityAPI:getEyeY() end
---Returns true if this entity is invisible, for one reason or another.
---@return boolean
function EntityAPI:isInvisible() end
---Returns true if this entity is currently standing in rain.
---@return boolean
function EntityAPI:isInRain() end
---Returns true if this entity is silent.
---@return boolean
function EntityAPI:isSilent() end
---Returns true if this entity's eyes are touching water.
---@return boolean
function EntityAPI:isUnderwater() end
---Returns true if this entity is currently in lava.
---@return boolean
function EntityAPI:isInLava() end
---Returns true if this entity is sneaking.
---@return boolean
function EntityAPI:isSneaking() end
---Returns true if this entity is currently sprinting.
---@return boolean
function EntityAPI:isSprinting() end
---Returns true if Figura has an avatar loaded for this entity.
---@return boolean
function EntityAPI:hasAvatar() end
---Returns true if this entity is currently glowing.
---@return boolean
function EntityAPI:isGlowing() end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@return BlockState
function EntityAPI:getTargetedBlock() end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@param ignoreLiquids boolean
---@return BlockState
function EntityAPI:getTargetedBlock(ignoreLiquids) end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@param ignoreLiquids boolean
---@param distance number
---@return BlockState
function EntityAPI:getTargetedBlock(ignoreLiquids, distance) end
---Returns true if this entity is currently on fire.
---@return boolean
function EntityAPI:isOnFire() end
---Gets the value of a variable this entity stored in themselves using the Avatar api's store() function.
---@param key string
---@return any
function EntityAPI:getVariable(key) end
