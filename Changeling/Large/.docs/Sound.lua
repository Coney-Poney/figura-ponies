---@diagnostic disable: duplicate-set-field
---Represents a sound that can be played. Obtained by indexing the SoundAPI. Exists as an object-oriented alternative to sounds:playSound().
---@class Sound
local Sound={}
---Plays this sound with the given parameters. Volume in Minecraft refers to how far away people can hear from, not the actual loudness. The defaults for volume and pitch are 1.
---@param pos Vector3
---@return nil
function Sound:play(pos) end
---Plays this sound with the given parameters. Volume in Minecraft refers to how far away people can hear from, not the actual loudness. The defaults for volume and pitch are 1.
---@param posX number
---@param posY number
---@param posZ number
---@return nil
function Sound:play(posX, posY, posZ) end
---Plays this sound with the given parameters. Volume in Minecraft refers to how far away people can hear from, not the actual loudness. The defaults for volume and pitch are 1.
---@param pos Vector3
---@param volume number
---@param pitch number
---@param loop boolean
---@return nil
function Sound:play(pos, volume, pitch, loop) end
---Plays this sound with the given parameters. Volume in Minecraft refers to how far away people can hear from, not the actual loudness. The defaults for volume and pitch are 1.
---@param posX number
---@param posY number
---@param posZ number
---@param volume number
---@param pitch number
---@param loop boolean
---@return nil
function Sound:play(posX, posY, posZ, volume, pitch, loop) end
