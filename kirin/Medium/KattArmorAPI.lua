--╔══════════════════════════════════════════════════════════════════════════╗--
--║                                                                          ║--
--║  ██  ██  ██████  ██████   █████    ██    ██████   ████    ████    ████   ║--
--║  ██ ██     ██      ██    ██       ████     ██    ██  ██  ██          ██  ║--
--║  ████      ██      ██    ██       █  █     ██     █████  █████    ████   ║--
--║  ██ ██     ██      ██    ██      ██████    ██        ██  ██  ██  ██      ║--
--║  ██  ██  ██████    ██     █████  ██  ██    ██     ████    ████    ████   ║--
--║                                                                          ║--
--╚══════════════════════════════════════════════════════════════════════════╝--

--v2.0.0

---@alias KattArmor.ArmorPartID KattItemChange.ArmorSlotID

---@alias KattArmor.ArmorMaterialID
---| "leather"
---| "chainmail"
---| "iron"
---| "golden"
---| "diamond"
---| "netherite"
---| "turtle"
---| string

---@class KattArmor.ArmorChangeEvent:KattEvent
---@field register fun(self:KattArmor.ArmorChangeEvent,func:KattArmor.ArmorChangeSubscription,name?:string)
---@alias KattArmor.ArmorChangeSubscription fun(arg:KattArmor.MutableEventArgs,armorID:KattArmor.ArmorPartID,material:KattArmor.ArmorMaterialID?,item:ItemStack,prevMaterial:KattArmor.ArmorMaterialID?,prevItem:ItemStack)
---@alias KattArmor.MutableEventArgs {visible:boolean,glint:boolean,color:Vector3,texture:string|Texture}

local ItemChange = require(((...):match("^(.*%.).+$") or "") .. "KattItemChangeEvent") --[[@as KattItemChange.API]]

---@type table<KattArmor.ArmorPartID,ModelPart[]>
local armorParts = {
  HELMET = {},
  CHESTPLATE = {},
  LEGGINGS = {},
  BOOTS = {},
}
---@type table<KattArmor.ArmorPartID,{forceRender:KattArmor.ArmorMaterialID?,prevMaterial:KattArmor.ArmorMaterialID?}>
local armorProperties = {
  HELMET = {},
  CHESTPLATE = {},
  LEGGINGS = {},
  BOOTS = {},
}

---@param armorID KattArmor.ArmorPartID
---@param ... ModelPart
local function addArmorPart(armorID, ...)
  if not armorParts[armorID] then error(("Expected valid ArmorPartID, recieved \"%s\""):format(armorID), 3) end
  local vararg = table.pack(...)
  for _, modelPart in ipairs(vararg) do
    if type(modelPart) ~= "ModelPart" then error(("Expected ModelPart, got %s"):format(type(modelPart)), 3) end
    table.insert(armorParts[armorID], modelPart)
  end
end

---@class KattArmor.API
local KattArmorAPI = {}
KattArmorAPI.onChange = require(((...):match("^(.*%.).+$") or "") .. "KattEventsAPI").newEvent() --[[@as KattArmor.ArmorChangeEvent]]
---@param armorID KattArmor.ArmorPartID
---@param ... ModelPart
function KattArmorAPI.addArmor(armorID, ...) addArmorPart(armorID, ...) end
---@param ... ModelPart
function KattArmorAPI.addHelmet(...) addArmorPart(ItemChange.ItemSlotIDs[6], ...) end
---@param ... ModelPart
function KattArmorAPI.addChestplate(...) addArmorPart(ItemChange.ItemSlotIDs[5], ...) end
---@param ... ModelPart
function KattArmorAPI.addLeggings(...) addArmorPart(ItemChange.ItemSlotIDs[4], ...) end
---@param ... ModelPart
function KattArmorAPI.addBoots(...) addArmorPart(ItemChange.ItemSlotIDs[3], ...) end

---@param armorID KattArmor.ArmorPartID
---@param materialID KattArmor.ArmorMaterialID
function KattArmorAPI.renderMaterial(armorID, materialID)
  if not armorParts[armorID] then error(("Expected valid ArmorPartID, recieved \"%s\""):format(armorID), 2) end
  armorProperties[armorID].forceRender = materialID
  ItemChange.forceUpdate(ItemChange.ItemSlots[armorID])
end

ItemChange.onItemChange:register(function(itemSlot, item, prevItem)
  if itemSlot <= 2 then return end
  local armorID = ItemChange.ItemSlotIDs[itemSlot] --[[@as KattArmor.ArmorPartID]]
  local armorMaterial = armorProperties[armorID].forceRender or string.match(item.id, ("^.*:(.*)_%s"):format(armorID:lower()))
  local isArmor = armorMaterial and true or false
  local visible = isArmor
  local glint = item:hasGlint()
  local color = 0xFFFFFF
  if armorMaterial == "leather" then
    color = item.tag and item.tag.display and item.tag.display.color or 0xA06540
  end
  color = vectors.intToRGB(color)
  local pathMaterial = armorMaterial
  if armorMaterial == "golden" then pathMaterial = "gold" end
  local layer = itemSlot == 4 and "2" or "1"
  local path = pathMaterial and ("minecraft:textures/models/armor/%s_layer_%s.png"):format(pathMaterial, layer)
  ---@type KattArmor.MutableEventArgs
  local eventArg = {
    visible = visible,
    glint = glint,
    color = color,
    texture = path,
  }
  
  KattArmorAPI.onChange(eventArg, armorID, armorMaterial, item, armorProperties[armorID].prevMaterial, prevItem)
  
  local eV, eC, eG, eT, eTT = eventArg.visible and nil, eventArg.color, eventArg.glint and "GLINT" or nil, eventArg.texture, nil
  do local _type = type(eT)
    eTT = _type == "Texture" and "CUSTOM"
      or _type == "string" and "RESOURCE"
      or "PRIMARY"
  end
  for _, modelPart in ipairs(armorParts[armorID]) do
    modelPart:setVisible(eV)
    modelPart:setColor(eC)
    modelPart:setPrimaryTexture(eTT, eT)
    modelPart:setSecondaryRenderType(eG)
  end
  armorProperties[armorID].prevMaterial = armorMaterial
end)

return KattArmorAPI
