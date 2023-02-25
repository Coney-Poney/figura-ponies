--╔══════════════════════════════════════════════════════════════════════════╗--
--║                                                                          ║--
--║  ██  ██  ██████  ██████   █████    ██    ██████   ████    ████    ████   ║--
--║  ██ ██     ██      ██    ██       ████     ██    ██  ██  ██          ██  ║--
--║  ████      ██      ██    ██       █  █     ██     █████  █████    ████   ║--
--║  ██ ██     ██      ██    ██      ██████    ██        ██  ██  ██  ██      ║--
--║  ██  ██  ██████    ██     █████  ██  ██    ██     ████    ████    ████   ║--
--║                                                                          ║--
--╚══════════════════════════════════════════════════════════════════════════╝--

--v1.0

local ItemChangeAPI = require((...):gsub("(.)$", "%1.") .. "KattItemChangeEvent") --[[@as KattItemChange.API]]

---@type table<KattArmor.ArmorPartID, table<KattArmor.ArmorMaterialID, ModelPart[]?>>
local parts = {
  HELMET = {},
  CHESTPLATE = {},
  LEGGINGS = {},
  BOOTS = {},
}

local API = {}

---Adds the given modelParts to be enabled when the given armorID wears the material `materialID`<br>
---A `materialID` of `false` will set ModelParts that will be invisible when there is any armor set equipped in the given slot, otherwise visible.
---@param armorID KattArmor.ArmorPartID
---@param materialID KattArmor.ArmorMaterialID | false
---@param ... ModelPart
function API.addModelPartToMaterial(armorID, materialID, ...)
  if not parts[armorID] then error(("Expected valid ArmorPartID, recieved \"%s\""):format(armorID), 2) end
  if not parts[armorID][materialID] then parts[armorID][materialID] = {} end
  local partList = parts[armorID][materialID]
  for index, modelPart in ipairs({ ... }) do
    if type(modelPart) ~= "ModelPart" then error(("Invalid type for varargs index %i. Expected a <ModelPart>, recieved <%s> %s"):format(index, type(modelPart), tostring(modelPart)), 2) end
    modelPart:setVisible(false)
    table.insert(partList, modelPart)
  end
  ItemChangeAPI.forceUpdate(ItemChangeAPI.ItemSlots[armorID])
end

require((...):gsub("(.)$", "%1.") .. "KattArmorAPI").onRender:register(function(arg, armorID, material, _, prevMaterial, _)
  if parts[armorID][prevMaterial or false] then
    for _, modelPart in ipairs(parts[armorID][prevMaterial or false]) do
      modelPart:setVisible(false)
    end
  end
  if parts[armorID][material or false] then
    local visible = material and (arg.visible and nil)
    for _, modelPart in ipairs(parts[armorID][material or false]) do
      modelPart:setVisible(visible)
    end
  end
end)

return API