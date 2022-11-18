---@diagnostic disable: duplicate-set-field
---A global API dedicated to reading information from the Minecraft world. Accessed using the name "world".
---@class WorldAPI
local WorldAPI={}
---Checks whether or not a world currently exists. This will almost always be true, but might be false on some occasions such as while travelling between dimensions.
---@return boolean
function WorldAPI.exists() end
---Gets the current game time of the world. If delta is passed in, then it adds delta to the time. The default value of delta is zero.
---@return number
function WorldAPI.getTime() end
---Gets the current game time of the world. If delta is passed in, then it adds delta to the time. The default value of delta is zero.
---@param delta number
---@return number
function WorldAPI.getTime(delta) end
---Gets the current day time of the world. If delta is passed in, then it adds delta to the time. The default value of delta is zero.
---@return number
function WorldAPI.getTimeOfDay() end
---Gets the current day time of the world. If delta is passed in, then it adds delta to the time. The default value of delta is zero.
---@param delta number
---@return number
function WorldAPI.getTimeOfDay(delta) end
---Returns an EntityAPI object from this UUID's entity, or nil if no entity was found.
---@param UUID string
---@return EntityAPI
function WorldAPI.getEntity(UUID) end
---Gets the direct redstone power level of the block at the given position.
---@param pos Vector3
---@return integer
function WorldAPI.getStrongRedstonePower(pos) end
---Gets the direct redstone power level of the block at the given position.
---@param x number
---@param y number
---@param z number
---@return integer
function WorldAPI.getStrongRedstonePower(x, y, z) end
---Gets the Biome located at the given position.
---@param pos Vector3
---@return Biome
function WorldAPI.getBiome(pos) end
---Gets the Biome located at the given position.
---@param x number
---@param y number
---@param z number
---@return Biome
function WorldAPI.getBiome(x, y, z) end
---Gets the sky light level of the block at the given position.
---@param pos Vector3
---@return integer
function WorldAPI.getSkyLightLevel(pos) end
---Gets the sky light level of the block at the given position.
---@param x number
---@param y number
---@param z number
---@return integer
function WorldAPI.getSkyLightLevel(x, y, z) end
---Gets the current moon phase of the world, stored as an integer.
---@return integer
function WorldAPI.getMoonPhase() end
---Gets the BlockState of the block at the given position.
---@param pos Vector3
---@return BlockState
function WorldAPI.getBlockState(pos) end
---Gets the BlockState of the block at the given position.
---@param x number
---@param y number
---@param z number
---@return BlockState
function WorldAPI.getBlockState(x, y, z) end
---Gets the current rain gradient in the world, interpolated from the previous tick to the current one. The default value of delta is 1, which is the current tick.
---@return number
function WorldAPI.getRainGradient() end
---Gets the current rain gradient in the world, interpolated from the previous tick to the current one. The default value of delta is 1, which is the current tick.
---@param delta number
---@return number
function WorldAPI.getRainGradient(delta) end
---Gets the redstone power level of the block at the given position.
---@param pos Vector3
---@return integer
function WorldAPI.getRedstonePower(pos) end
---Gets the redstone power level of the block at the given position.
---@param x number
---@param y number
---@param z number
---@return integer
function WorldAPI.getRedstonePower(x, y, z) end
---Gets whether or not the sky is open at the given position.
---@param pos Vector3
---@return boolean
function WorldAPI.isOpenSky(pos) end
---Gets whether or not the sky is open at the given position.
---@param x number
---@param y number
---@param z number
---@return boolean
function WorldAPI.isOpenSky(x, y, z) end
---Returns a table containing instances of Player for all players in the world. The players are indexed by their names.
---@return Player[]
function WorldAPI.getPlayers() end
---Gets the block light level of the block at the given position.
---@param pos Vector3
---@return integer
function WorldAPI.getBlockLightLevel(pos) end
---Gets the block light level of the block at the given position.
---@param x number
---@param y number
---@param z number
---@return integer
function WorldAPI.getBlockLightLevel(x, y, z) end
---Parses and create a new BlockState from the given string. A world position can be optionally given for the blockstate functions that relies on its position.
---@param block string
---@return BlockState
function WorldAPI.newBlock(block) end
---Parses and create a new BlockState from the given string. A world position can be optionally given for the blockstate functions that relies on its position.
---@param block string
---@param pos Vector3
---@return BlockState
function WorldAPI.newBlock(block, pos) end
---Parses and create a new BlockState from the given string. A world position can be optionally given for the blockstate functions that relies on its position.
---@param block string
---@param x number
---@param y number
---@param z number
---@return BlockState
function WorldAPI.newBlock(block, x, y, z) end
---Returns a table from all players in the world containing variables stored from their Avatar api's store() function. The players are indexed by their names.
---@return table<string,table>
function WorldAPI.playerVars() end
---Gets the overall light level of the block at the given position.
---@param pos Vector3
---@return integer
function WorldAPI.getLightLevel(pos) end
---Gets the overall light level of the block at the given position.
---@param x number
---@param y number
---@param z number
---@return integer
function WorldAPI.getLightLevel(x, y, z) end
---Gets whether or not there is currently thunder/lightning happening in the world.
---@return boolean
function WorldAPI.isThundering() end
---Parses and create a new ItemStack from the given string. A count and damage can be given, to be applied on this itemstack.
---@param item string
---@return ItemStack
function WorldAPI.newItem(item) end
---Parses and create a new ItemStack from the given string. A count and damage can be given, to be applied on this itemstack.
---@param item string
---@param count integer
---@return ItemStack
function WorldAPI.newItem(item, count) end
---Parses and create a new ItemStack from the given string. A count and damage can be given, to be applied on this itemstack.
---@param item string
---@param count integer
---@param damage integer
---@return ItemStack
function WorldAPI.newItem(item, count, damage) end
