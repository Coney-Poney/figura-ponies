---@diagnostic disable: duplicate-set-field
---Acts as a proxy for a player entity in the Minecraft world. A global instance exists for the avatar's user, under the name "player".
---@class PlayerAPI:LivingEntityAPI
local PlayerAPI={}
---Gets the progress of the way towards the player's next level, as a value from 0 to 1.
---@return number
function PlayerAPI:getExperienceProgress() end
---Gets the current food level of the player, from 0 to 20.
---@return integer
function PlayerAPI:getFood() end
---Gets the current saturation level of the player.
---@return number
function PlayerAPI:getSaturation() end
---Returns whether the specified skin layer, from the Skin Customizations settings, is currently visible.
---@param part PlayerModelParts
---@return boolean
function PlayerAPI:isSkinLayerVisible(part) end
---Returns "SLIM" or "DEFAULT", depending on the player's model type.
---@return "DEFAULT" | "SLIM"
function PlayerAPI:getModelType() end
---Returns whether the player is currently flying.
---@return boolean
function PlayerAPI:isFlying() end
---Gets the player's current level.
---@return number
function PlayerAPI:getExperienceLevel() end
---Returns "SURVIVAL", "CREATIVE", "ADVENTURE", or "SPECTATOR" depending on the player's gamemode. If the gamemode is unknown, returns nil.
---@return "SURVIVAL" | "CREATIVE" | "ADVENTURE" | "SPECTATOR"
function PlayerAPI:getGamemode() end
---Returns the number of bee stingers sticking out of this entity.
---@return integer
function PlayerAPI:getStingerCount() end
---Returns, as a table, all of the status effects this entity has on it. The table contains sub-tables, each of which contains the name, amplifier, duration, and particle visibility of an effect this entity has.
---@return {visible:boolean,duration:number,amplifier:number,name:string}[]
function PlayerAPI:getStatusEffects() end
---Returns an ItemStack representing the item in this entity's main hand. If true is passed in for "offhand", then it will instead look at the item in the entity's offhand. If the entity isn't holding an item in that hand, returns nil.
---@return ItemStack
function PlayerAPI:getHeldItem() end
---Returns an ItemStack representing the item in this entity's main hand. If true is passed in for "offhand", then it will instead look at the item in the entity's offhand. If the entity isn't holding an item in that hand, returns nil.
---@param offhand boolean
---@return ItemStack
function PlayerAPI:getHeldItem(offhand) end
---Returns an ItemStack representing the item the entity is currently using. If they're not using any item, returns nil.
---@return ItemStack
function PlayerAPI:getActiveItem() end
---Gets the yaw of this entity's body in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the body between the previous tick and the current tick. The default value of delta is 1.
---@return number
function PlayerAPI:getBodyYaw() end
---Gets the yaw of this entity's body in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the body between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return number
function PlayerAPI:getBodyYaw(delta) end
---Returns the amount of health this entity has remaining.
---@return number
function PlayerAPI:getHealth() end
---Returns the number of ticks this entity has been dead for.
---@return number
function PlayerAPI:getDeathTime() end
---Returns the amount of armor points this entity has.
---@return number
function PlayerAPI:getArmor() end
---Returns the maximum amount of health this entity can have.
---@return number
function PlayerAPI:getMaxHealth() end
---Returns the number of arrows sticking out of this entity.
---@return integer
function PlayerAPI:getArrowCount() end
---Returns true if the entity's main hand is its left.
---@return boolean
function PlayerAPI:isLeftHanded() end
---Returns true if the entity is currently using a climbable block, like a ladder or vine.
---@return boolean
function PlayerAPI:isClimbing() end
---Returns true if the entity is currently using an item.
---@return boolean
function PlayerAPI:isUsingItem() end
---Returns "OFF_HAND" or "MAIN_HAND", depending on which hand this entity uses an item with.
---@return "MAIN_HAND" | "OFF_HAND"
function PlayerAPI:getActiveHand() end
---Gets the name of this entity, if it has a custom name. If it doesn't, returns a translated form of getType().
---@return string
function PlayerAPI:getName() end
---Gets the Minecraft identifier of this entity. For instance, "minecraft:pig".
---@return string
function PlayerAPI:getType() end
---Checks if this entity object is still being updated and loaded. A non loaded entity would be someone who is in another dimension or out of the render distance for example.
---@return boolean
function PlayerAPI:isLoaded() end
---Gets an ItemStack for the item in the given slot. For the player, slots are indexed with 1 as the main hand, 2 as the off hand, and 3,4,5,6 as the 4 armor slots from the boots to the helmet. If an invalid slot number is given, or if the entity has no item in that slot, this will return nil.
---@param index integer
---@return ItemStack
function PlayerAPI:getItem(index) end
---Gets a table containing the NBT of this entity. Please note that not all values in the entity's NBT may be synced, as some are handled only on server side.
---@return table
function PlayerAPI:getNbt() end
---Gets the maximum amount of air this entity can have.
---@return integer
function PlayerAPI:getMaxAir() end
---Gets the current velocity of this entity in world coordinates, calculated as its position this tick minus its position last tick.
---@return Vector3
function PlayerAPI:getVelocity() end
---Gets the Minecraft identifier of the dimension this entity is in.
---@return string
function PlayerAPI:getDimensionName() end
---Gets the UUID of the proxied entity.
---@return string
function PlayerAPI:getUUID() end
---Returns a unit vector pointing in the direction that this entity is looking. See the blue line in the F3+B screen for an example.
---@return Vector3
function PlayerAPI:getLookDir() end
---Gets the rotation of the entity in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the entity between the previous tick and the current tick. The default value of delta is 1.
---@return Vector2
function PlayerAPI:getRot() end
---Gets the rotation of the entity in degrees. If delta is passed in, then it will be used to linearly interpolate the rotation of the entity between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return Vector2
function PlayerAPI:getRot(delta) end
---Gets the current amount of air this entity has remaining.
---@return integer
function PlayerAPI:getAir() end
---Returns whether or not this entity is currently on the ground.
---@return boolean
function PlayerAPI:isOnGround() end
---"Refused to elaborate."
---@return boolean
function PlayerAPI:isHamburger() end
---Returns the current eye height of this entity.
---@return number
function PlayerAPI:getEyeHeight() end
---Gets the number of ticks this entity has been freezing in powder snow for.
---@return integer
function PlayerAPI:getFrozenTicks() end
---Returns a proxy for the entity that this player is currently riding. If the player isn't riding anything, returns nil.
---@return EntityAPI
function PlayerAPI:getVehicle() end
---Gets the position of the entity in the world. If delta is passed in, then it will be used to linearly interpolate the position of the entity between the previous tick and the current tick. The default value of delta is 1.
---@return Vector3
function PlayerAPI:getPos() end
---Gets the position of the entity in the world. If delta is passed in, then it will be used to linearly interpolate the position of the entity between the previous tick and the current tick. The default value of delta is 1.
---@param delta number
---@return Vector3
function PlayerAPI:getPos(delta) end
---Returns the remaining number of ticks this entity will be on fire for.
---@return integer
function PlayerAPI:getFireTicks() end
---Returns the size of this entity's bounding box as a Vector3. {x, y, z} are the width, height, and width. Minecraft entity hitboxes always have square bases.
---@return Vector3
function PlayerAPI:getBoundingBox() end
---Returns the current pose of the player. This can be one of: "STANDING", "FALL_FLYING", "SLEEPING", "SWIMMING", "SPIN_ATTACK", "CROUCHING", "LONG_JUMPING", or "DYING".
---@return EntityPoses
function PlayerAPI:getPose() end
---Returns true if this entity is currently in a water block, including waterlogging.
---@return boolean
function PlayerAPI:isInWater() end
---Returns true in any of three conditions: if the entity is in water, if the entity is in rain, or if the entity is in a bubble column. Otherwise, returns false.
---@return boolean
function PlayerAPI:isWet() end
---Returns the Y level of this entity's eyes. Not to be confused with getEyeHeight, this function also takes the entity itself's Y position into account.
---@return number
function PlayerAPI:getEyeY() end
---Returns true if this entity is invisible, for one reason or another.
---@return boolean
function PlayerAPI:isInvisible() end
---Returns true if this entity is currently standing in rain.
---@return boolean
function PlayerAPI:isInRain() end
---Returns true if this entity is silent.
---@return boolean
function PlayerAPI:isSilent() end
---Returns true if this entity's eyes are touching water.
---@return boolean
function PlayerAPI:isUnderwater() end
---Returns true if this entity is currently in lava.
---@return boolean
function PlayerAPI:isInLava() end
---Returns true if this entity is sneaking.
---@return boolean
function PlayerAPI:isSneaking() end
---Returns true if this entity is currently sprinting.
---@return boolean
function PlayerAPI:isSprinting() end
---Returns true if Figura has an avatar loaded for this entity.
---@return boolean
function PlayerAPI:hasAvatar() end
---Returns true if this entity is currently glowing.
---@return boolean
function PlayerAPI:isGlowing() end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@return BlockState
function PlayerAPI:getTargetedBlock() end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@param ignoreLiquids boolean
---@return BlockState
function PlayerAPI:getTargetedBlock(ignoreLiquids) end
---Returns a proxy for your currently targeted BlockState. This BlockState appears on the F3 screen. Maximum and Default distance is 20, Minimum is -20
---@param ignoreLiquids boolean
---@param distance number
---@return BlockState
function PlayerAPI:getTargetedBlock(ignoreLiquids, distance) end
---Returns true if this entity is currently on fire.
---@return boolean
function PlayerAPI:isOnFire() end
---Gets the value of a variable this entity stored in themselves using the Avatar api's store() function.
---@param key string
---@return any
function PlayerAPI:getVariable(key) end
