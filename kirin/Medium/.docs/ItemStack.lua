---@diagnostic disable: duplicate-set-field
---A proxy for an item stack from Minecraft.
---@class ItemStack
---@field id string Contains the id of the item this ItemStack refers to.
---@field tag table A table containing the NBT tag of this ItemStack. If this ItemStack has nothing in its tag, it is nil.
local ItemStack={}
---Gets the name of the item.
---@return string
function ItemStack:getName() end
---Gets the number of items in this stack.
---@return integer
function ItemStack:getCount() end
---Gets all the tags of this item as strings in a table.
---@return string[]
function ItemStack:getTags() end
---Returns true if this item glows with enchantment glint.
---@return boolean
function ItemStack:hasGlint() end
---Gets the damage value of the item in this stack. Works on things like tools, or other things with a durability bar.
---@return integer
function ItemStack:getDamage() end
---Returns true if this item is edible.
---@return boolean
function ItemStack:isFood() end
---Gets the maximum stack size of this item.
---@return integer
function ItemStack:getMaxCount() end
---Returns the name of the animation that plays when using this item.
---@return "NONE" | "EAT" | "DRINK" | "BOW" | "CROSSBOW" | "BLOCK" | "SPEAR" | "SPYGLASS"
function ItemStack:getUseAction() end
---Returns true if this item represents a block.
---@return boolean
function ItemStack:isBlockItem() end
---Gets the remaining cooldown on this item, in ticks.
---@return integer
function ItemStack:getCooldown() end
---Gets the number of ticks needed to "use" this item. Currently only has a use for food items. Always 32 for food items except kelp, which is 16.
---@return integer
function ItemStack:getUseDuration() end
---Gets the repair cost modifier, in an anvil, for this item stack.
---@return integer
function ItemStack:getRepairCost() end
---Gets the maximum durability of this item stack.
---@return integer
function ItemStack:getMaxDamage() end
---Returns true if the item is stackable.
---@return boolean
function ItemStack:isStackable() end
---Returns true if this item stack can be put in an enchanting table.
---@return boolean
function ItemStack:isEnchantable() end
---Gets the rarity of this item stack. COMMON = white, UNCOMMON = yellow, RARE = aqua, EPIC = light purple.
---@return string|"COMMON"|"UNCOMMON"|"RARE"|"EPIC"
function ItemStack:getRarity() end
---Returns true if this item stack has durability.
---@return boolean
function ItemStack:isDamageable() end
---Converts this ItemStack to a string, like you'd see in a command.
---@return string
function ItemStack:toStackString() end
