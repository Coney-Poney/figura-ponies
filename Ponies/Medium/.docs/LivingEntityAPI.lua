---@diagnostic disable: duplicate-set-field
---Acts as a proxy for a living entity in the Minecraft world.
---@class LivingEntityAPI:EntityAPI
local LivingEntityAPI={}
---Returns the number of bee stingers sticking out of this entity.
---@return integer
function LivingEntityAPI:getStingerCount() end
---Returns, as a table, all of the status effects this entity has on it. The table contains sub-tables, each of which contains the name, amplifier, duration, and particle visibility of an effect this entity has.
---@return {visible:boolean,duration:number,amplifier:number,name:string}[]
function LivingEntityAPI:getStatusEffects() end
---Returns an ItemStack representing the item in this entity's main hand. If true is passed in for "offhand", then it will instead look at the item in the entity's offhand. If the entity isn't holding an item in that hand, returns nil.
---@return ItemStack
function LivingEntityAPI:getHeldItem() end
---Returns an ItemStack representing the item in this entity's main hand. If true is passed in for "offhand", then it will instead look at the item in the entity's offhand. If the entity isn't holding an item in that hand, returns nil.
---@param offhand boolean
---@return ItemStack
function LivingEntityAPI:getHeldItem(offhand) end
---Returns an ItemStack representing the item the entity is currently using. If they're not using any item, returns nil.
---@return ItemStack
function LivingEntityAPI:getActiveItem() end
---Gets the yaw of this entity's body in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the body between the previous tick and the current tick. The default value of delta is 1.
---@return number
function LivingEntityAPI:getBodyYaw() end
---Gets the yaw of this entity's body in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the body between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return number
function LivingEntityAPI:getBodyYaw(delta) end
---Returns the amount of health this entity has remaining.
---@return number
function LivingEntityAPI:getHealth() end
---Returns the number of ticks this entity has been dead for.
---@return number
function LivingEntityAPI:getDeathTime() end
---Returns the amount of armor points this entity has.
---@return number
function LivingEntityAPI:getArmor() end
---Returns the maximum amount of health this entity can have.
---@return number
function LivingEntityAPI:getMaxHealth() end
---Returns the number of arrows sticking out of this entity.
---@return integer
function LivingEntityAPI:getArrowCount() end
---Returns true if the entity's main hand is its left.
---@return boolean
function LivingEntityAPI:isLeftHanded() end
---Returns true if the entity is currently using a climbable block, like a ladder or vine.
---@return boolean
function LivingEntityAPI:isClimbing() end
---Returns true if the entity is currently using an item.
---@return boolean
function LivingEntityAPI:isUsingItem() end
---Returns "OFF_HAND" or "MAIN_HAND", depending on which hand this entity uses an item with.
---@return "MAIN_HAND" | "OFF_HAND"
function LivingEntityAPI:getActiveHand() end
---Gets the name of this entity, if it has a custom name. If it doesn't, returns a translated form of getType().
---@return string
function LivingEntityAPI:getName() end
---Gets the Minecraft identifier of this entity. For instance, "minecraft:pig".
---@return string
function LivingEntityAPI:getType() end
---Checks if this entity object is still being updated and loaded. A non loaded entity would be someone who is in another dimension or out of the render distance for example.
---@return boolean
function LivingEntityAPI:isLoaded() end
---Gets an ItemStack for the item in the given slot. For the player, slots are indexed with 1 as the main hand, 2 as the off hand, and 3,4,5,6 as the 4 armor slots from the boots to the helmet. If an invalid slot number is given, or if the entity has no item in that slot, this will return nil.
---@param index integer
---@return ItemStack
function LivingEntityAPI:getItem(index) end
---Gets a table containing the NBT of this entity. Please note that not all values in the entity's NBT may be synced, as some are handled only on server side.
---@return table
function LivingEntityAPI:getNbt() end
---Gets the maximum amount of air this entity can have.
---@return integer
function LivingEntityAPI:getMaxAir() end
---Gets the current velocity of this entity in world coordinates, calculated as its position this tick minus its position last tick.
---@return Vector3
function LivingEntityAPI:getVelocity() end
---Gets the Minecraft identifier of the dimension this entity is in.
---@return string
function LivingEntityAPI:getDimensionName() end
---Gets the UUID of the proxied entity.
---@return string
function LivingEntityAPI:getUUID() end
---Returns a unit vector pointing in the direction that this entity is looking. See the blue line in the F3+B screen for an example.
---@return Vector3
function LivingEntityAPI:getLookDir() end
---Gets the rotation of the entity in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the entity between the previous tick and the current tick. The default value of delta is 1.
---@return Vector2
function LivingEntityAPI:getRot() end
---Gets the rotation of the entity in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the entity between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return Vector2
function LivingEntityAPI:getRot(delta) end
---Gets the current amount of air this entity has remaining.
---@return integer
function LivingEntityAPI:getAir() end
---Returns whether or not this entity is currently on the ground.
---@return boolean
function LivingEntityAPI:isOnGround() end
---"Refused to elaborate."
---@return boolean
function LivingEntityAPI:isHamburger() end
---Returns the current eye height of this entity.
---@return number
function LivingEntityAPI:getEyeHeight() end
---Gets the number of ticks this entity has been freezing in powder snow for.
---@return integer
function LivingEntityAPI:getFrozenTicks() end
---Returns a proxy for the entity that this player is currently riding. If the player isn't riding anything, returns nil.
---@return EntityAPI
function LivingEntityAPI:getVehicle() end
---Gets the position of the entity in the world. If delta is passed in, then it will be used to linearly interpolate the position of the entity between the previous tick and the current tick. The default value of delta is 1.
---@return Vector3
function LivingEntityAPI:getPos() end
---Gets the position of the entity in the world. If delta is passed in, then it will be used to linearly interpolate the position of the entity between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return Vector3
function LivingEntityAPI:getPos(delta) end
---Returns the remaining number of ticks this entity will be on fire for.
---@return integer
function LivingEntityAPI:getFireTicks() end
---Returns the size of this entity's bounding box as a Vector3. {x, y, z} are the width, height, and width. Minecraft entity hitboxes always have square bases.
---@return Vector3
function LivingEntityAPI:getBoundingBox() end
---Returns the current pose of the player. This can be one of: "STANDING", "FALL_FLYING", "SLEEPING", "SWIMMING", "SPIN_ATTACK", "CROUCHING", "LONG_JUMPING", or "DYING".
---@return EntityPoses
function LivingEntityAPI:getPose() end
---Returns true if this entity is currently in a water block, including waterlogging.
---@return boolean
function LivingEntityAPI:isInWater() end
---Returns true in any of three conditions: if the entity is in water, if the entity is in rain, or if the entity is in a bubble column. Otherwise, returns false.
---@return boolean
function LivingEntityAPI:isWet() end
---Returns the Y level of this entity's eyes. Not to be confused with getEyeHeight, this function also takes the entity itself's Y position into account.
---@return number
function LivingEntityAPI:getEyeY() end
---Returns true if this entity is invisible, for one reason or another.
---@return boolean
function LivingEntityAPI:isInvisible() end
---Returns true if this entity is currently standing in rain.
---@return boolean
function LivingEntityAPI:isInRain() end
---Returns true if this entity is silent.
---@return boolean
function LivingEntityAPI:isSilent() end
---Returns true if this entity's eyes are touching water.
---@return boolean
function LivingEntityAPI:isUnderwater() end
---Returns true if this entity is currently in lava.
---@return boolean
function LivingEntityAPI:isInLava() end
---Returns true if this entity is sneaking.
---@return boolean
function LivingEntityAPI:isSneaking() end
---Returns true if this entity is currently sprinting.
---@return boolean
function LivingEntityAPI:isSprinting() end
---Returns true if Figura has an avatar loaded for this entity.
---@return boolean
function LivingEntityAPI:hasAvatar() end
---Returns true if this entity is currently glowing.
---@return boolean
function LivingEntityAPI:isGlowing() end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@return BlockState
function LivingEntityAPI:getTargetedBlock() end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@param ignoreLiquids boolean
---@return BlockState
function LivingEntityAPI:getTargetedBlock(ignoreLiquids) end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@param ignoreLiquids boolean
---@param distance number
---@return BlockState
function LivingEntityAPI:getTargetedBlock(ignoreLiquids, distance) end
---Returns true if this entity is currently on fire.
---@return boolean
function LivingEntityAPI:isOnFire() end
---Gets the value of a variable this entity stored in themselves using the Avatar api's store() function.
---@param key string
---@return any
function LivingEntityAPI:getVariable(key) end
