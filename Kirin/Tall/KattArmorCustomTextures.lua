--╔══════════════════════════════════════════════════════════════════════════╗--
--║                                                                          ║--
--║  ██  ██  ██████  ██████   █████    ██    ██████   ████    ████    ████   ║--
--║  ██ ██     ██      ██    ██       ████     ██    ██  ██  ██          ██  ║--
--║  ████      ██      ██    ██       █  █     ██     █████  █████    ████   ║--
--║  ██ ██     ██      ██    ██      ██████    ██        ██  ██  ██  ██      ║--
--║  ██  ██  ██████    ██     █████  ██  ██    ██     ████    ████    ████   ║--
--║                                                                          ║--
--╚══════════════════════════════════════════════════════════════════════════╝--

--v1.1

local forceUpdate = require(((...):match("^(.*%.).+$") or "") .. "KattItemChangeEvent").forceUpdate

local materialTextureMap = {{}, {}}

local CustomTextureAPI = {}
---Sets the ArmorMaterial to render using the given texture.
---@param material KattArmor.ArmorMaterialID
---@param texture Texture?
function CustomTextureAPI.assignTextureToMaterial(material, texture)
  if type(texture) ~= "Texture" then error(("Invalid type for parameter `texture`. Expected a <Texture>, recieved <%s> %s"):format(type(texture), tostring(texture)), 2) end
  materialTextureMap[1][material] = texture
  forceUpdate()
end

---Sets the Layer2 texture of this Material to use the given texture.
---Should this be `nil`, Layer2 will use the texture assigned by `assignTextureToMaterial`
---@param material KattArmor.ArmorMaterialID
---@param texture Texture?
function CustomTextureAPI.assignTextureToMaterialLayer2(material, texture)
  if type(texture) ~= "Texture" then error(("Invalid type for parameter `texture`. Expected a <Texture>, recieved <%s> %s"):format(type(texture), tostring(texture)), 2) end
  materialTextureMap[2][material] = texture
  forceUpdate()
end

require(((...):match("^(.*%.).+$") or "") .. "KattArmorAPI").onChange:register(function(arg, armorID, material)
  local layer = armorID == "LEGGINGS" and materialTextureMap[2][material] and 2 or 1
  if materialTextureMap[layer][material] then
    arg.texture = materialTextureMap[layer][material]
  end
end)

return CustomTextureAPI
