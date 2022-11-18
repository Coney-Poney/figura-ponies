---@diagnostic disable: duplicate-set-field
---Represents a model part in a vanilla model. Can be set visible and invisible, and queried for rotation and position offsets.
---@class VanillaModelPart
local VanillaModelPart={}
---Sets this part to be visible or invisible.
---@param visible boolean
---@return nil
function VanillaModelPart:setVisible(visible) end
---Gets whether you have set this part to be visible or invisible. Only responds to your own changes in script, not anything done by Minecraft.
---@return boolean
function VanillaModelPart:getVisible() end
---Gets if this vanilla model part is visible or not, without interference from your script.
---@return boolean
function VanillaModelPart:getOriginVisible() end
---Gets the position offset to this vanilla model part currently applied by Minecraft.
---@return Vector3
function VanillaModelPart:getOriginPos() end
---Gets the rotation to this vanilla model part currently applied by Minecraft.
---@return Vector3
function VanillaModelPart:getOriginRot() end
