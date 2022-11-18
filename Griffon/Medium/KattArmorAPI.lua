--╔══════════════════════════════════════════════════════════════════════════╗--
--║                                                                          ║--
--║  ██  ██  ██████  ██████   █████    ██    ██████   ████    ████    ████   ║--
--║  ██ ██     ██      ██    ██       ████     ██    ██  ██  ██          ██  ║--
--║  ████      ██      ██    ██       █  █     ██     █████  █████    ████   ║--
--║  ██ ██     ██      ██    ██      ██████    ██        ██  ██  ██  ██      ║--
--║  ██  ██  ██████    ██     █████  ██  ██    ██     ████    ████    ████   ║--
--║                                                                          ║--
--╚══════════════════════════════════════════════════════════════════════════╝--

--v1.1.3

---@alias ArmorPartID
---| "helmet"
---| "chestplate"
---| "leggings"
---| "boots"

---These are the materialIDs of the vanilla armors.
---For modded armors, remove the `<namespace>:` and the `_<ArmorPartID>` from the itemId, and you are left with the materialID.
---9/10 cases this will match with the texture but if it doesn't, you can use the `setTextureNameOverride` function to fix it.
---@alias ArmorMaterialID
---| "leather"
---| "chainmail"
---| "iron"
---| "golden"
---| "diamond"
---| "netherite"
---| "turtle"
---| string

---@class ArmorPart
---@field current string
---@field layer 1|2
---@field slot 3|4|5|6
---@field parts ModelPart[]
---@field updates boolean Whether this ArmorPart checks for updates. Default false, but gets enabled when a part is added.
---@field updateWasForced boolean Set to true whenever the armor is forcfully updated. Used for the callback function.
---@field visible boolean Forcefully set whether this armorPart is visible.

---@class ArmorMaterial
---@field color number
---@field disable boolean Whether to disable the armor when this material is enabled.
---@field customTexture Vector2
---@field textureNameOverride string Changes the file that is accessed. Format must follow "minecraft:textures/models/armor/<name>_layer_<1|2>.png". Most modded armors place their armor in the `minecraft` namespace.
---@field pathOverride1 string Completely overrides the path of the accessed armor. Usefull for custom resource packs.
---@field pathOverride2 string Same, but for layer_2 if defined.

---@class EventArgs
---@field item string The item that the armor was changed to.
---@field prevItem string The item that the armor was changed from.
---@field armorPart ArmorPartID The slot that was changed.
---@field armorMaterial ArmorMaterialID The new material of the armor.
---@field color number The new color of the armor.
---@field glint boolean Whether this item has the enchant gling
---@field isArmor boolean Whether this item was reconized as armor for this slot.
---@field isVisible boolean Whether this armorPart is visible.
---@field updateWasForced boolean `true` if this change was caused by a forced update.
---@field texturePath string The vanilla texture that this armor points to. Only effective if textureType is "resource".
---@field textureType string The type of texture that this armor uses, whether it is a vanilla texture "resource" or the custom texture "texture"/`nil`

local metaProperties = {
  armorTextureSize = vec(1, 1)
}

---@type table<ArmorPartID,ArmorPart>
local armorProperties = {
  helmet = {
    current = nil,
    layer = 1,
    slot = 6,
    parts = {}
  },
  chestplate = {
    current = nil,
    layer = 1,
    slot = 5,
    parts = {}
  },
  leggings = {
    current = nil,
    layer = 2,
    slot = 4,
    parts = {}
  },
  boots = {
    current = nil,
    layer = 1,
    slot = 3,
    parts = {}
  }
}
---@type table<ArmorMaterialID,ArmorMaterial>
local materialProperties = {
  leather = {
    color = 0xA06540
  },
  golden = {
    textureNameOverride = "gold"
  }
}

---Prints a warning message, but continues operations as usual.
---@param ... any
local function warn(...)
  local r=""
  for _, v in ipairs({...}) do
    r=r..tostring(v)
  end
  print("\n§6[warn]:§r " .. r)
end

---@param armorPart ArmorPartID
local function forceValidArmorPart(armorPart)
  if not armorProperties[armorPart] then
    error('argument "armorPart" is not a valid ID. Valid IDs are "helmet", "chestplate", "leggings", and "boots".', 3)
  end
end

local API = {}

do
  local Meta = {}

  ---Forces the given armorPart to update on the next tick.
  ---@param armorPart string
  ---@param overrideWasForced boolean? Default `false`. If set to `true`, the `updateWasForced field of a callback object will be false dispite this being a forced update.
  function Meta.forceUpdate(armorPart, overrideWasForced)
    forceValidArmorPart(armorPart)
    armorProperties[armorPart].current = nil
    armorProperties[armorPart].updateWasForced = not overrideWasForced
  end

  ---Forces all armorParts to update
  ---@param overrideWasForced boolean? Default `false`. If set to `true`, the `updateWasForced field of a callback object will be false dispite this being a forced update.
  function Meta.forceUpdateAll(overrideWasForced)
    for armorPart, _ in pairs(armorProperties) do
      Meta.forceUpdate(armorPart, overrideWasForced)
    end
  end

  function Meta.set(propertyName, value)
    metaProperties[propertyName] = value
  end

  ---Sets the size of the armor texture, measured in materials.
  ---@param width integer The width of the material matrix
  ---@param height integer The height of the material matrix
  ---@overload fun(size:Vector2)
  function Meta.setArmorTextureSize(width, height)
    local size
    if type(width) == "Vector2" then
      size = width:copy()
    elseif type(width) == "number" and type(height) == "number" then
      size = vec(width, height)
    else
      error('illegal arguments. Must be either 2 numbers or a Vector2', 2)
    end
    Meta.set("armorTextureSize", size)
    Meta.forceUpdateAll()
  end

  API.Meta = Meta

  local Armor = {}
  ---Links the modelPart with the given armorPart.
  ---A table array of modelParts can also be given.
  ---@param armorPart ArmorPartID
  ---@param ... ModelPart|ModelPart[]
  function Armor.add(armorPart, ...)
    forceValidArmorPart(armorPart)
    for _, part in pairs { ... } do
      if type(part) == "table" then
        Armor.add(armorPart, table.unpack(part))
      elseif type(part) == "ModelPart" then
        table.insert(armorProperties[armorPart].parts, part)
      else
        warn("Attempted to add illegal item to ArmorAPI: ",part)
      end
    end
    armorProperties[armorPart].updates = true
    armorProperties[armorPart].visible = true
    Meta.forceUpdate(armorPart)
  end

  ---Removes the modelPart with the given name from the script's control.
  ---If there are multiple parts with the same name, only the first one gets removed.
  ---Returns the modelPart that was removed or `nil` if none were removed.
  ---@param armorPart ArmorPartID
  ---@param modelPartName string
  ---@return ModelPart|nil
  function Armor.remove(armorPart, modelPartName)
    forceValidArmorPart(armorPart)
    local returnPart
    for i, modelPart in ipairs(armorProperties[armorPart].parts) do
      if modelPart:getName() == modelPartName then
        returnPart = table.remove(armorProperties[armorPart].parts, i)
        break
      end
    end
    if returnPart then
      returnPart:setVisible()
      returnPart:setPrimaryTexture()
      returnPart:setColor()
      returnPart:setSecondaryRenderType()
    end
    return returnPart
  end

  ---Links the modelPart with the Helmet
  ---A table array of modelParts can also be given.
  ---@param ... ModelPart|ModelPart[]
  function Armor.addHelmet(...)
    Armor.add("helmet", ...)
  end

  ---Links the modelPart with the Chestplate
  ---A table array of modelParts can also be given.
  ---@param ... ModelPart|ModelPart[]
  function Armor.addChestplate(...)
    Armor.add("chestplate", ...)
  end

  ---Links the modelPart with the Leggings
  ---A table array of modelParts can also be given.
  ---@param ... ModelPart|ModelPart[]
  function Armor.addLeggings(...)
    Armor.add("leggings", ...)
  end

  ---Links the modelPart with the Boots
  ---A table array of modelParts can also be given.
  ---@param ... ModelPart|ModelPart[]
  function Armor.addBoots(...)
    Armor.add("boots", ...)
  end

  ---@type ArmorPartID[]
  local armorPartIdIterator
  ---Returns a table of armorPartIDs allowing for iterating over API functions.
  ---@return ArmorPartID[]
  function Armor.getIterator()
    if not armorPartIdIterator then
      armorPartIdIterator = {}
      for armorPartId, _ in pairs(armorProperties) do
        table.insert(armorPartIdIterator, armorPartId)
      end
    end
    return armorPartIdIterator
  end

  API.Armor = Armor

  local ArmorProperty = {}
  ---Sets an armor property.
  ---This function bypasses all type checking so unless you know what you are doing, use one of the named set functions.
  ---@param armorPart ArmorPartID
  ---@param propertyName string
  ---@param value any
  function ArmorProperty.set(armorPart, propertyName, value)
    forceValidArmorPart(armorPart)
    armorProperties[armorPart][propertyName] = value
    Meta.forceUpdate(armorPart)
  end

  ---Sets the texture layer that the armor will render as.
  ---A value of 1 will use the helmet, chestplate, boots texture, while 2 will use the leggings texture.
  ---@param armorPart ArmorPartID
  ---@param integear 1|2
  function ArmorProperty.setTextureLayer(armorPart, integear)
    forceValidArmorPart(armorPart)
    if integear ~= 1 and integear ~= 2 then
      error("Invalid armor texture layer. Must be numbers '1' or '2'.", 2)
    end
    ArmorProperty.set(armorPart, "layer", integear)
  end

  ---Sets whether this armorPart will check for changes. `false` by default, but gets automatically enabled when a part is added.
  ---@param armorPart ArmorPartID
  ---@param boolean boolean
  function ArmorProperty.setUpdates(armorPart, boolean)
    forceValidArmorPart(armorPart)
    ArmorProperty.set(armorPart, "updates", boolean)
  end

  ---Sets whether the armorPart is visible. `false` by default, but gets automatically enabled when a part is added.
  ---@param armorPart ArmorPartID
  ---@param boolean boolean
  function ArmorProperty.setVisible(armorPart, boolean)
    forceValidArmorPart(armorPart)
    ArmorProperty.set(armorPart, "visible", boolean)
  end

  API.ArmorProperty = ArmorProperty

  local MaterialProperty = {}
  ---Sets a material property. Best to use one of the named property functions rather than this.
  ---@param armorMaterial ArmorMaterialID
  ---@param propertyName string
  ---@param value any
  function MaterialProperty.set(armorMaterial, propertyName, value)
    if not materialProperties[armorMaterial] then
      materialProperties[armorMaterial] = {}
    end
    materialProperties[armorMaterial][propertyName] = value
    Meta.forceUpdateAll()
  end

  ---Sets the material to use the texture in blockbench rather than the vanilla texture.
  ---A Vector2 is used to determine which armorTexture in the matrix to use.
  ---Alternativly, set to `true` for default or `false` to unset.
  ---@param armorMaterial ArmorMaterialID
  ---@param armorIndex boolean|Vector2
  function MaterialProperty.setCustomTexture(armorMaterial, armorIndex)
    if armorIndex and type(armorIndex) == "boolean" then armorIndex = vec(1, 1) end
    if armorIndex and type(armorIndex) ~= "Vector2" then
      error('argument "armorIndex" must be a vector2 or a boolean', 2)
    end
    if armorIndex.x > metaProperties.armorTextureSize.x or armorIndex.y > metaProperties.armorTextureSize.y then
      print(warn(
        "The given vector for material \"'..armorMaterial..'\" is larger than what is defined as the texture size.\n",
        "If not intended, use the \"Meta.setArmorTextureSize\" function to set the the texture size.\n",
        "If this is intended, use the \"MaterialProperty.set\" function with the \"customTexture\" propertyName to bypass this warning."
      )
      )
    end
    MaterialProperty.set(armorMaterial, "customTexture", armorIndex)
  end

  ---Sets if the material respects the `display.color` tag.
  ---Takes a number that represents the default color of the armorPart.
  ---Set to `nil` to disable color.
  ---Also has the side effect of tinting the armor the given color :P
  ---@param armorMaterial ArmorMaterialID
  ---@param color number|Vector3|nil
  function MaterialProperty.setColor(armorMaterial, color)
    if type(color) == "number" then
    elseif type(color) == "Vector3" then color = vectors.rgbToInt(color)
    else color=nil end
    MaterialProperty.set(armorMaterial, "color", color)
  end

  ---Sets if this material is to be rendered.
  ---@param armorMaterial ArmorMaterialID
  ---@param boolean boolean
  function MaterialProperty.setDisabled(armorMaterial, boolean)
    MaterialProperty.set(armorMaterial, "disable", boolean)
  end

  ---Completely overrides the path that this material will pull its texture from.
  ---Can set `layer_1Path` and `layer_2Path` seperatly. Otherwise, both textures will pull from the path defined in `layer_1Path`.
  ---Setting both to `nil` will reset it.
  ---@param armorMaterial ArmorMaterialID
  ---@param layer_1Path string?
  ---@param layer_2Path string?
  function MaterialProperty.setPathOverride(armorMaterial, layer_1Path, layer_2Path)
    MaterialProperty.set(armorMaterial, "pathOverride1", layer_1Path)
    MaterialProperty.set(armorMaterial, "pathOverride2", layer_2Path)
  end

  ---Changes the texture that this material pulles from.
  ---Format is "minecraft:textures/models/armor/<textureName>_layer_<1|2>.png" where <textureName> is what is inputed and <1|2> gets replaced depending on the layer the armor part pulls from.
  ---Can be used to either fix some modded armors or just for the purpose of giving leather armor the same texture as netherite :P
  ---@param armorMaterial ArmorMaterialID
  ---@param textureName string
  function MaterialProperty.setTextureNameOverride(armorMaterial, textureName)
    MaterialProperty.set(armorMaterial, "textureNameOverride", textureName)
  end

  API.MaterialProperty = MaterialProperty


  local Events = {}
  pcall(function()
    Events.EventsAPI = require("KattEventsAPI")
  end)
  if Events.EventsAPI then
    Events.onChange = Events.EventsAPI:new()
  else
    Events.onChange = setmetatable({},{__index=function ()
      error("Attempted to use event when KattEventsAPI is not installed.",2)
    end})
  end
  API.Events = Events
end

events.TICK:register(
  function()
    for armorPart, armorProperty in pairs(armorProperties) do
      if armorProperty.updates then
        local armorItem = player:getItem(armorProperty.slot)
        if armorItem:toStackString() ~= armorProperty.current then
          ---@type EventArgs
          local eventArgs = {}
          do
            eventArgs.updateWasForced = armorProperty.updateWasForced
            armorProperty.updateWasForced = false

            eventArgs.armorPart = armorPart
            eventArgs.prevItem = armorProperty.current
            eventArgs.item = armorItem.id
            local namespace, armorMaterial = string.match(armorItem.id, "^(.*):(.*)_" .. armorPart)
            eventArgs.armorMaterial = armorMaterial

            local materialProperty = materialProperties[armorMaterial]

            local color = 0xFFFFFF
            if materialProperty and materialProperty.color then
              color = armorItem.tag.display and armorItem.tag.display.color or
                  (materialProperty.color or 0xFFFFFF)
            end
            eventArgs.color = color
            local vColor = vectors.intToRGB(color)

            local valid = not not armorMaterial
            eventArgs.isArmor = valid

            local glint = armorItem:hasGlint() and "GLINT" or nil
            eventArgs.glint = armorItem:hasGlint()

            eventArgs.isVisible = armorProperty.visible
            if not armorProperty.visible or
                (materialProperty and materialProperty.disable) then
              for _, modelPart in pairs(armorProperties[armorPart].parts) do
                modelPart:setVisible(false)
              end
              goto finalizePart
            end

            if not valid then
              for _, modelPart in pairs(armorProperties[armorPart].parts) do
                modelPart:setVisible(false)
              end
              goto finalizePart
            end

            local path = ""
            if materialProperty and materialProperty.pathOverride1 then
              if armorProperty.layer == 2 and materialProperty.pathOverride2 then
                path = materialProperty.pathOverride2
              else
                path = materialProperty.pathOverride1
              end
            else
              path = "minecraft:textures/models/armor/" ..
                  (materialProperty and materialProperty.textureNameOverride or armorMaterial) ..
                  "_layer_" .. armorProperty.layer .. ".png"
            end
            local customTexture = materialProperty and materialProperty.customTexture
            local textureType = customTexture and "PRIMARY" or "RESOURCE"
            local uvOffset = customTexture and
                ((materialProperty.customTexture.xy - vec(1, 1)) / metaProperties.armorTextureSize)
                or vec(0, 0)
            local uvScale = customTexture and vec(1, 1, 1) or metaProperties.armorTextureSize.xy_
            local tempMatrix = matrices.mat3()
            for _, modelPart in pairs(armorProperties[armorPart].parts) do
              modelPart:setVisible()
              modelPart:setColor(vColor)
              modelPart:setPrimaryTexture(textureType, path)
              modelPart:setSecondaryRenderType(glint)
              tempMatrix:scale(uvScale)
              tempMatrix:translate(uvOffset)
              modelPart:setUVMatrix(tempMatrix)
              tempMatrix:reset()
            end
            eventArgs.texturePath = path
            eventArgs.textureType = textureType
          end

          ::finalizePart::
          armorProperty.current = armorItem and armorItem:toStackString()
          if API.Events.EventsAPI then
            API.Events.onChange:invoke(eventArgs)
          end
        end
      end
    end
  end
)

return API
