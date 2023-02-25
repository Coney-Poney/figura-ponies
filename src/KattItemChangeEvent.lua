--╔══════════════════════════════════════════════════════════════════════════╗--
--║                                                                          ║--
--║  ██  ██  ██████  ██████   █████    ██    ██████   ████    ████    ████   ║--
--║  ██ ██     ██      ██    ██       ████     ██    ██  ██  ██          ██  ║--
--║  ████      ██      ██    ██       █  █     ██     █████  █████    ████   ║--
--║  ██ ██     ██      ██    ██      ██████    ██        ██  ██  ██  ██      ║--
--║  ██  ██  ██████    ██     █████  ██  ██    ██     ████    ████    ████   ║--
--║                                                                          ║--
--╚══════════════════════════════════════════════════════════════════════════╝--

--v1.1.2
local EventAPI = require((...):gsub("(.)$", "%1.") .. "KattEventsAPI", function()
  error("KattEventsAPI.lua is needed for this script to work!", 2)
end) --[[@as KattEvent.API]]

---@alias KattItemChange.ItemData{current:ItemStack?,forceUpdate:boolean,forceItem:ItemStack?}

---@type table<KattItemChange.ItemSlot,KattItemChange.ItemData>
local slotProperties = {{}, {}, {}, {}, {}, {}}

---@class KattItemChange.API
local KattItemChangeAPI = EventAPI.eventifyTable({})

---@enum KattItemChange.ItemSlot
---Index by an ItemSlotID and get the slot number.
KattItemChangeAPI.ItemSlots = {
  MAIN_HAND = 1,
  OFF_HAND = 2,
  BOOTS = 3,
  LEGGINGS = 4,
  CHESTPLATE = 5,
  HELMET = 6,
}
---Alias for the string representation of the hand slots
---@alias KattItemChange.HandSlotID
---| "MAIN_HAND"
---| "OFF_HAND"

---Alias for the string representation of the armor slots
---@alias KattItemChange.ArmorSlotID
---| "HELMET"
---| "CHESTPLATE"
---| "LEGGINGS"
---| "BOOTS"

---Alias for the string representation of the item slots
---@alias KattItemChange.ItemSlotID
---| KattItemChange.HandSlotID
---| KattItemChange.ArmorSlotID

---Index by a slot number and get the ID of that slot.
KattItemChangeAPI.ItemSlotIDs = {
  "MAIN_HAND",
  "OFF_HAND",
  "BOOTS",
  "LEGGINGS",
  "CHESTPLATE",
  "HELMET",
}

---@alias KattItemChange.Event.Subscription fun(itemSlot:KattItemChange.ItemSlot,item:ItemStack,prevItem:ItemStack)
---@class KattItemChange.Event:KattEvent
---@field register fun(self:KattItemChange.Event,func:KattItemChange.Event.Subscription,name?:string)

---The event that will be invoked when any equipment slot changes.
KattItemChangeAPI.onItemChange = EventAPI.newEvent() --[[@as KattItemChange.Event]]

---Triggers the given slot to invoke the event.
---Calling function with no arguments causes all slots to update.
---@param slot KattItemChange.ItemSlot?
function KattItemChangeAPI.forceUpdate(slot)
  if not slot then
    for _, slotProperty in ipairs(slotProperties) do
      slotProperty.forceUpdate = true
    end
    return
  end
  if not slotProperties[slot] then error(("Invalid Type. Expected a <KattItemChange.ItemSlot>, recieved <%s> %s"):format(type(slot), tostring(slot)), 2) end
  slotProperties[slot].forceUpdate = true
end

---Forces the API to trigger as if the provided item is in the given slot.
---Providing `nil` for the item will resume default behavior.
---@param slot KattItemChange.ItemSlot
---@param item (ItemStack | Minecraft.itemID)?
function KattItemChangeAPI.forceItem(slot, item)
  if not slotProperties[slot] then error(("Invalid type for parameter `slot`. Expected a <KattItemChange.ItemSlot>, recieved <%s> %s"):format(type(slot), tostring(slot)), 2) end
  if type(item) == "string" then
    local validItem, _item = pcall(world.newItem, item)
    if not validItem then error(("Invalid string for parameter `item`. Expected valid itemID, recieved \"%s\""):format(item), 2) end
    item = _item
  end
  if type(item) ~= "ItemStack" then error(("Invalid type for parameter `item`. Expected an ItemStack, recieved <%s> %s"):format(type(item), tostring(item)), 2) end
  slotProperties[slot].forceItem = item
  KattItemChangeAPI.forceUpdate(slot)
end

function events.tick()
  for itemSlot, itemData in pairs(slotProperties) do
    local itemStack = itemData.forceItem or player:getItem(itemSlot--[[@as EntityAPI.slot]] )
    if itemData.forceUpdate or itemStack ~= itemData.current then
      local item = world.newItem(itemStack:toStackString(), itemStack:getCount())
      KattItemChangeAPI.onItemChange(itemSlot, item, itemData.current)
      itemData.current = item
      itemData.forceUpdate = false
    end
  end
end

return KattItemChangeAPI
