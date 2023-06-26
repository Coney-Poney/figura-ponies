--================================================--
--   _  ___ _    ____      _    ___   __  ____    --
--  | |/ (_) |_ / ___|__ _| |_ / _ \ / /_|___ \   --
--  | ' /| | __| |   / _` | __| (_) | '_ \ __) |  --
--  | . \| | |_| |__| (_| | |_ \__, | (_) / __/   --
--  |_|\_\_|\__|\____\__,_|\__|  /_/ \___/_____|  --
--                                                --
--================================================--

--v3.1

---@alias KattArmor.ArmorPartID
---| '"Helmet"'
---| '"Chestplate"'
---| '"Leggings"'
---| '"Boots"'

---@alias KattArmor.ArmorPartSlot
---| 6
---| 5
---| 4
---| 3

---@alias KattArmor.ArmorMaterialID string
---| '"leather"'
---| '"chainmail"'
---| '"iron"'
---| '"golden"'
---| '"diamond"'
---| '"netherite"'
---| '"turtle"'
---| true

local function Class()
  local cls = {}
  function cls.__index(_, index) return cls[index] end

  function cls.new(...)
    local i = {}
    if cls.init then cls.init(i, ...) end
    return setmetatable(i, cls)
  end

  return cls;
end

---@alias KattArmor.ArmorPart.Layer 1|2

---@class KattArmor.ArmorPart
---@field parts ModelPart[]
---@field layer KattArmor.ArmorPart.Layer
---@field override KattArmor.ArmorMaterialID?
---@field update boolean
---@field prevItem ItemStack
---@field prevMaterial KattArmor.Material
---
---@field new fun():KattArmor.ArmorPart
local ArmorPart = Class()
ArmorPart.__type = "ArmorPart"
function ArmorPart:init()
  self.parts = {}
  self.update = true
  self.layer = 1
end

---Add ModelParts that act as Armor Parts, switching textures based on the currently equipped armor.
---@param ... ModelPart
---@return self
function ArmorPart:addParts(...)
  for i, modelPart in ipairs({ ... }) do
    if type(modelPart) ~= "ModelPart" then
      error(
        ("Expected ModelPart, got %s (%s) at index %i in varargs"):format(tostring(modelPart),
          type(modelPart), i), 2)
    end
    table.insert(self.parts, modelPart)
  end
  return self
end

---Sets the texture layer that this ArmorPart uses.
---If there is no layer2 texture defined in the material, the normal texture will be used.
---This is purly just here for vanilla leggings compatibility, though there might be a smart use for this.
---@param layer KattArmor.ArmorPart.Layer
---@return self
function ArmorPart:setLayer(layer)
  if layer ~= 2 then layer = 1 end
  self.layer = layer
  return self
end

---Forces the given material to render, ignoring the auto-found material.
---@param material KattArmor.ArmorMaterialID?
---@return self
function ArmorPart:setMaterial(material)
  if material ~= self.override then
    self.override = material
    self:forceUpdate()
  end
  return self
end

---This function triggers the ArmorPart to update on the next tick.
---This should be done if the ArmorPart is dynamically modified at all, or if any of the ArmorMaterials are modified/created.
---@return self
function ArmorPart:forceUpdate()
  self.update = true
  return self
end

---@alias KattArmor.Material.Texture Texture | string | nil

---@class KattArmor.Material:Class
---@field visible boolean
---@field texture table<KattArmor.ArmorPart.Layer, KattArmor.Material.Texture>
---@field texture_e table<KattArmor.ArmorPart.Layer, KattArmor.Material.Texture>
---@field defaultColor integer
---@field parts table<KattArmor.ArmorPart, ModelPart[]>
---@field materialPartsColor boolean
---@field damageOverlay boolean
---
---@field new fun():KattArmor.Material
local Material = Class()
ArmorPart.__type = "ArmorMaterial"
function Material:init()
  self.parts = {}
  self.visible = true
  self.texture = {}
  self.texture_e = {}
  self.materialPartsColor = false
  self.damageOverlay = false
end

---Adds ModelParts that will only be active while this Material is active for the given ArmorPart
---@param armorPart KattArmor.ArmorPart
---@param ... ModelPart
---@return self
function Material:addParts(armorPart, ...)
  if not self.parts[armorPart] then self.parts[armorPart] = {} end
  for i, modelPart in ipairs({ ... }) do
    if type(modelPart) ~= "ModelPart" then
      error(
        ("Expected ModelPart, got %s (%s) at index %i in varargs"):format(tostring(modelPart),
          type(modelPart), i), 2)
    end
    table.insert(self.parts[armorPart], modelPart:setVisible(false))
  end
  return self
end

---Should this valid Material render?
---Used for the `[true]` material so that it doesnt render by default.
---@param visible boolean
---@return self
function Material:setVisible(visible)
  self.visible = visible
  return self
end

---Sets the `layer_1` texture for this material.
---@param texture KattArmor.Material.Texture
---@return self
function Material:setTexture(texture)
  self.texture[1] = texture
  return self
end

---Sets the `layer_2` texture for this material.
---@param texture KattArmor.Material.Texture
---@return self
function Material:setTextureLayer2(texture)
  self.texture[2] = texture
  return self
end

---Sets the `layer_1` emissive texture for this material.
---@param texture KattArmor.Material.Texture
---@return self
function Material:setEmissiveTexture(texture)
  self.texture_e[1] = texture
  return self
end

---Sets the `layer_2` emissive texture for this material.
---@param texture KattArmor.Material.Texture
---@return self
function Material:setEmissiveTextureLayer2(texture)
  self.texture_e[2] = texture
  return self
end

---Sets the default color of this material, which will be overriden by the `display.color` nbt tag on the ItemStack, if found.
---This is purly here just for leather armor compatibility.
---@param color integer
---@return self
function Material:setDefaultColor(color)
  self.defaultColor = color
  return self
end

---Sets if the Material Parts that only exist for this material should obey the color set by the item.
---This is purly here just for leather armor compatibility, and Jimmy.
---@param bool boolean
---@return self
function Material:setMaterialPartsColorChange(bool)
  self.materialPartsColor = bool
  return self
end

---Sets if this Material should flash red when the player takes damage.
---Default `false`.
---@param bool boolean
---@return self
function Material:setDamageOverlay(bool)
  self.damageOverlay = bool
  return self
end

---@type table<KattArmor.ArmorPartID, KattArmor.ArmorPartSlot>
local ArmorPart_SlotID_Map = {
  Helmet = 6,
  Chestplate = 5,
  Leggings = 4,
  Boots = 3,
}
---@type table<KattArmor.ArmorPartSlot, KattArmor.ArmorPartID>
local SlotID_ArmorPart_Map = {
  [6] = "Helmet",
  [5] = "Chestplate",
  [4] = "Leggings",
  [3] = "Boots",
}

---@type table<KattArmor.ArmorPartID, KattArmor.ArmorPart>
local armor = setmetatable({
  Helmet = ArmorPart:new(),
  Chestplate = ArmorPart:new(),
  Leggings = ArmorPart:new():setLayer(2),
  Boots = ArmorPart:new(),
}, {
  __pairs = function(self)
    local i = 6
    return function(t, k)
      local id = SlotID_ArmorPart_Map[i]
      i = i - 1
      return id, t[id]
    end, self
  end,
})

local armorTexturePath = "minecraft:textures/models/armor/%s_layer_%s.png"

---@type table<KattArmor.ArmorMaterialID, KattArmor.Material>
local materials = setmetatable({},
  {
    __index = function(self, index)
      local newMaterial = Material:new()
      if type(index) == "string" then
        local t = armorTexturePath:format(index, "1")
        if client.hasResource(t) then
          newMaterial:setTexture(t)
          local t2 = armorTexturePath:format(index, "2")
          if client.hasResource(t2) then newMaterial:setTextureLayer2(t2) end
          local t_e = armorTexturePath:format(index, "1_e")
          if client.hasResource(t_e) then
            newMaterial:setEmissiveTexture(t_e)
            local t2_e = armorTexturePath:format(index, "2_e")
            if client.hasResource(t2_e) then newMaterial:setEmissiveTextureLayer2(t2_e) end
          end
        end
      end
      rawset(self, index, newMaterial)
      return newMaterial
    end,
  })
materials[true]:setVisible(false):setDamageOverlay(true)
materials.leather:setDefaultColor(0xA06540)
rawset(materials, "golden", materials.gold)

local api = {
  ---Table that stores all of the ArmorPart objects that can be edited.
  Armor = armor,
  ---Table that stores all of the ArmorMaterials.<br>
  ---Indexing this will create a new ArmorMaterial.
  Materials = materials,
  ---A table that maps ArmorParts to Equipment Slots.
  ArmorPart_SlotID_Map = ArmorPart_SlotID_Map,
  ---A table that maps Equipment Slots to ArmorParts
  SlotID_ArmorPart_Map = SlotID_ArmorPart_Map,
  ---@type nil|fun(partID:KattArmor.ArmorPartID, part:KattArmor.ArmorPart, item:ItemStack, prevItem:ItemStack)
  onChange = nil,
}

local textureTypeMap = { string = "RESOURCE", Texture = "CUSTOM" }
function events.TICK()
  for part, partData in pairs(armor) do
    local item = player:getItem(ArmorPart_SlotID_Map[part]):copy()
    if not (partData.update or item ~= partData.prevItem) then goto CONTINUE end

    if partData.prevMaterial and partData.prevMaterial.parts[partData] then
      for _, modelPart in ipairs(partData.prevMaterial.parts[partData]) do
        modelPart:setVisible(false)
      end
    end

    if api.onChange then api.onChange(part, partData, item, partData.prevItem) end

    partData.update = false

    local material = partData.override or
        item.id:match(("^.*:(.*)_%s"):format(part:lower())) or true
    local materialData = materials[material]

    local visible = materialData.visible and nil

    local texture = materialData.texture[partData.layer]
    local textureType = textureTypeMap[type(texture)]

    local texture_e = materialData.texture_e[partData.layer]
    local textureType_e = textureTypeMap[type(texture_e)]

    local color = vectors.intToRGB(
      item.tag and item.tag.display and item.tag.display.color or
      materialData.defaultColor or 0xFFFFFF
    )
    local renderType = item:hasGlint() and "GLINT" or "EMISSIVE"

    local damageOverlay = (not materialData.damageOverlay) and 0 or nil

    for _, modelPart in ipairs(partData.parts) do
      modelPart
          :setVisible(visible)
          :setPrimaryTexture(textureType, texture)
          :setSecondaryTexture(textureType_e, texture_e)
          :setColor(color)
          :setSecondaryRenderType(renderType)
          :setOverlay(damageOverlay, 15)
    end

    if materialData.parts[partData] then
      local materialPartsColor = materialData.materialPartsColor and color or 0xFFFFFF
      for _, modelPart in ipairs(materialData.parts[partData]) do
        modelPart
            :setVisible()
            :setSecondaryRenderType(renderType)
            :setColor(materialPartsColor)
            :setOverlay(damageOverlay, 15)
      end
    end

    partData.prevMaterial = materialData
    partData.prevItem = item

    ::CONTINUE::
  end
end

return api
