---@diagnostic disable: duplicate-set-field
---A nameplate customization that is specialized for entities.
---@class EntityNameplateCustomization:NameplateCustomization
---@field visible boolean Whether or not should the nameplate be rendered.
---@field shadow boolean Whether or not should the nameplate have shadow. Incompatible with "outline".
---@field outline boolean Whether or not should the nameplate have outline. Incompatible with "shadow".
local EntityNameplateCustomization={}
---Sets the scale factor of the nameplate.
---@param scale Vector3
---@return nil
function EntityNameplateCustomization:setScale(scale) end
---Sets the scale factor of the nameplate.
---@param x number
---@param y number
---@param z number
---@return nil
function EntityNameplateCustomization:setScale(x, y, z) end
---Gets the position offset of the nameplate, in world coordinates.
---@return Vector3
function EntityNameplateCustomization:getPos() end
---Sets the position offset of the nameplate, in world coordinates.
---@param pos Vector3
---@return nil
function EntityNameplateCustomization:setPos(pos) end
---Sets the position offset of the nameplate, in world coordinates.
---@param x number
---@param y number
---@param z number
---@return nil
function EntityNameplateCustomization:setPos(x, y, z) end
---Gets scale factor of the nameplate.
---@return Vector3
function EntityNameplateCustomization:getScale() end
---Sets the color of the nameplate background. If the alpha value is not given, it will uses the vanilla value (from the accessibility settings) for it.
---@param rgb Vector3
---@return nil
function EntityNameplateCustomization:setBackgroundColor(rgb) end
---Sets the color of the nameplate background. If the alpha value is not given, it will uses the vanilla value (from the accessibility settings) for it.
---@param rgba Vector4
---@return nil
function EntityNameplateCustomization:setBackgroundColor(rgba) end
---Sets the color of the nameplate background. If the alpha value is not given, it will uses the vanilla value (from the accessibility settings) for it.
---@param rgb Vector3
---@param a number
---@return nil
function EntityNameplateCustomization:setBackgroundColor(rgb, a) end
---Sets the color of the nameplate background. If the alpha value is not given, it will uses the vanilla value (from the accessibility settings) for it.
---@param r number
---@param g number
---@param b number
---@return nil
function EntityNameplateCustomization:setBackgroundColor(r, g, b) end
---Sets the color of the nameplate background. If the alpha value is not given, it will uses the vanilla value (from the accessibility settings) for it.
---@param r number
---@param g number
---@param b number
---@param a number
---@return nil
function EntityNameplateCustomization:setBackgroundColor(r, g, b, a) end
---The text to use in this nameplate.
---@param text string
---@return nil
function EntityNameplateCustomization:setText(text) end
---The text to use in this nameplate.
---@return string
function EntityNameplateCustomization:getText() end
