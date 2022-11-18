---@diagnostic disable: duplicate-set-field
---A proxy for a Minecraft biome. Instances are obtained through the WorldAPI. This proxy also contains a saved position for the Biome.
---@class Biome
local Biome={}
---Returns the name of the biome, according to the registry.
---@return string
function Biome:getName() end
---Returns the saved position for this Biome's proxy. The saved position is used in Biome functions that require a position.
---@return Vector3
function Biome:getPos() end
---Sets the saved position for this Biome's proxy. The saved position is used in Biome functions that require a position.
---@param pos Vector3
---@return nil
function Biome:setPos(pos) end
---Sets the saved position for this Biome's proxy. The saved position is used in Biome functions that require a position.
---@param x number
---@param y number
---@param z number
---@return nil
function Biome:setPos(x, y, z) end
---Gets this biome's humidity.
---@return number
function Biome:getDownfall() end
---Gets the temperature of this biome.
---@return number
function Biome:getTemperature() end
---Gets this biome's sky color as a RGB vector.
---@return Vector3
function Biome:getSkyColor() end
---Gets this biome's grass color as a RGB vector.
---@return Vector3
function Biome:getGrassColor() end
---Gets this biome's foliage color as a RGB vector.
---@return Vector3
function Biome:getFoliageColor() end
---Gets this biome's fog color as a RGB vector.
---@return Vector3
function Biome:getFogColor() end
---Gets this biome's water color as a RGB vector.
---@return Vector3
function Biome:getWaterColor() end
---Gets this biome's water fog color as a RGB vector.
---@return Vector3
function Biome:getWaterFogColor() end
---Checks if this biome is hot.
---@return boolean
function Biome:isHot() end
---Checks if this biome is cold.
---@return boolean
function Biome:isCold() end
---Gets the rain type of this biome. The type can be "NONE", "RAIN" or "SNOW".
---@return "NONE" | "RAIN" | "SNOW"
function Biome:getPrecipitation() end
