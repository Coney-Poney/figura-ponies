---@diagnostic disable: duplicate-set-field
---A global API providing functions that change the way Minecraft renders your player.
---@class RendererAPI
---@field renderFire boolean Whether or not you should visually have the fire effect while on fire. True by default.
---@field renderVehicle boolean Whether or not your vehicle (boat, minecart, horse, whatever) will be rendered. True by default.
---@field renderCrosshair boolean Toggles whether or not if your crosshair should render. True by default.
---@field forcePaperdoll boolean Toggles if the paperdoll should render regardless of the player doing an action. If the paperdoll is disabled, or set to always render, nothing will change. False by default.
local RendererAPI={}
---Gets the offset pivot for the camera.
---@return Vector3
function RendererAPI:getCameraOffsetPivot() end
---Gets the position offset for the camera.
---@return Vector3
function RendererAPI:getCameraPos() end
---Sets the radius of your shadow. The default value is nil, which means to use the vanilla default of 0.5 for players. The maximum value is 12.
---@return nil
function RendererAPI:setShadowRadius() end
---Sets the radius of your shadow. The default value is nil, which means to use the vanilla default of 0.5 for players. The maximum value is 12.
---@param radius number
---@return nil
function RendererAPI:setShadowRadius(radius) end
---Sets the position offset for the camera. Nil values for position are assumed to be 0.
---@param pos Vector3
---@return nil
function RendererAPI:setCameraPos(pos) end
---Sets the position offset for the camera. Nil values for position are assumed to be 0.
---@param x number
---@param y number
---@param z number
---@return nil
function RendererAPI:setCameraPos(x, y, z) end
---Checks if your camera is in the backwards third person view.
---@return boolean
function RendererAPI:isCameraBackwards() end
---Gets the absolute pivot for the camera.
---@return Vector3
function RendererAPI:getCameraPivot() end
---Sets the offset pivot for the camera. The pivot will also move the camera. Its values are relative to the world. Nil values for pivot are assumed to be 0. For relative rotation values, check out the non-offset pivot function.
---@param pivot Vector3
---@return nil
function RendererAPI:offsetCameraPivot(pivot) end
---Sets the offset pivot for the camera. The pivot will also move the camera. Its values are relative to the world. Nil values for pivot are assumed to be 0. For relative rotation values, check out the non-offset pivot function.
---@param x number
---@param y number
---@param z number
---@return nil
function RendererAPI:offsetCameraPivot(x, y, z) end
---Gets the absolute rotation of the camera.
---@return Vector3
function RendererAPI:getCameraRot() end
---Sets the absolute rotation of the camera. The position is not taken into account for roll. Nil values for rotation are assumed to be 0. For relative rotation values, check out the "offset" rot function.
---@param rot Vector3
---@return nil
function RendererAPI:setCameraRot(rot) end
---Sets the absolute rotation of the camera. The position is not taken into account for roll. Nil values for rotation are assumed to be 0. For relative rotation values, check out the "offset" rot function.
---@param x number
---@param y number
---@param z number
---@return nil
function RendererAPI:setCameraRot(x, y, z) end
---Gets the offset rotation for the camera.
---@return Vector3
function RendererAPI:getCameraOffsetRot() end
---Sets the offset rotation for the camera. Nil values for rotation are assumed to be 0. Angles are given in degrees. For absolute rotation values, check out the non-offset rot function.
---@param rot Vector3
---@return nil
function RendererAPI:offsetCameraRot(rot) end
---Sets the offset rotation for the camera. Nil values for rotation are assumed to be 0. Angles are given in degrees. For absolute rotation values, check out the non-offset rot function.
---@param x number
---@param y number
---@param z number
---@return nil
function RendererAPI:offsetCameraRot(x, y, z) end
---Sets the absolute pivot for the camera. The pivot will also move the camera. Its values are relative to the World. Nil values for pivot are assumed to be 0. For relative rotation values, check out the "offset" pivot function.
---@param pivot Vector3
---@return nil
function RendererAPI:setCameraPivot(pivot) end
---Sets the absolute pivot for the camera. The pivot will also move the camera. Its values are relative to the World. Nil values for pivot are assumed to be 0. For relative rotation values, check out the "offset" pivot function.
---@param x number
---@param y number
---@param z number
---@return nil
function RendererAPI:setCameraPivot(x, y, z) end
---Gets the radius of your shadow. The default value is nil, which means to use the vanilla default of 0.5 for players.
---@return number
function RendererAPI:getShadowRadius() end
---Checks if your camera is in the first person view.
---@return boolean
function RendererAPI:isFirstPerson() end
---Sets the current rendering effect. Same as the discontinued Super Secret Settings.
---@param effect string
---@return nil
function RendererAPI:setPostEffect(effect) end
