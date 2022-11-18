---@diagnostic disable: duplicate-set-field
---A customization that can be applied to a nameplate.
---@class NameplateCustomization
local NameplateCustomization={}
---The text to use in this nameplate.
---@param text string
---@return nil
function NameplateCustomization:setText(text) end
---The text to use in this nameplate.
---@return string
function NameplateCustomization:getText() end
