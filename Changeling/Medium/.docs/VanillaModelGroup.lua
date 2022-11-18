---@diagnostic disable: duplicate-set-field
---Represents a group of model parts in a vanilla model. Used for easy reference of normal parts. Can only be set visible and invisible.
---@class VanillaModelGroup
local VanillaModelGroup={}
---Sets this parts to be visible or invisible.
---@param visible boolean
---@return nil
function VanillaModelGroup:setVisible(visible) end
---Gets whether you have set this parts to be visible or invisible. Only responds to your own changes in script, not anything done by Minecraft.
---@return boolean
function VanillaModelGroup:getVisible() end
