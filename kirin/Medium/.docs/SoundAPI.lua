---@diagnostic disable: duplicate-set-field
---A global API which is used to play Minecraft sounds. Accessed using the name "sounds".
---@class SoundAPI
local SoundAPI={}
---Stops the playing sounds from this avatar. If an id is specified, it only stops the sounds from that id.
---@return nil
function SoundAPI:stopSound() end
---Stops the playing sounds from this avatar. If an id is specified, it only stops the sounds from that id.
---@param id string
---@return nil
function SoundAPI:stopSound(id) end
---Plays the specified sound at the specified position with the given volume and pitch multipliers. The sound id is either an identifier or the custom sound name. Volume in Minecraft refers to how far away people can hear the sound from, not the actual loudness of it. If you don't give values for volume and pitch, the default values are 1.
---@param sound string
---@param pos Vector3
---@return nil
function SoundAPI:playSound(sound, pos) end
---Plays the specified sound at the specified position with the given volume and pitch multipliers. The sound id is either an identifier or the custom sound name. Volume in Minecraft refers to how far away people can hear the sound from, not the actual loudness of it. If you don't give values for volume and pitch, the default values are 1.
---@param sound string
---@param posX number
---@param posY number
---@param posZ number
---@return nil
function SoundAPI:playSound(sound, posX, posY, posZ) end
---Plays the specified sound at the specified position with the given volume and pitch multipliers. The sound id is either an identifier or the custom sound name. Volume in Minecraft refers to how far away people can hear the sound from, not the actual loudness of it. If you don't give values for volume and pitch, the default values are 1.
---@param sound string
---@param pos Vector3
---@param volume number
---@param pitch number
---@param loop boolean
---@return nil
function SoundAPI:playSound(sound, pos, volume, pitch, loop) end
---Plays the specified sound at the specified position with the given volume and pitch multipliers. The sound id is either an identifier or the custom sound name. Volume in Minecraft refers to how far away people can hear the sound from, not the actual loudness of it. If you don't give values for volume and pitch, the default values are 1.
---@param sound string
---@param posX number
---@param posY number
---@param posZ number
---@param volume number
---@param pitch number
---@param loop boolean
---@return nil
function SoundAPI:playSound(sound, posX, posY, posZ, volume, pitch, loop) end
---Registers a new custom sound for this avatar. The first argument is the sound id while the second argument is either a byte array of the sound data, or a base64 string representation of the same.
---@param name string
---@param byteArray table
---@return nil
function SoundAPI:addSound(name, byteArray) end
---Registers a new custom sound for this avatar. The first argument is the sound id while the second argument is either a byte array of the sound data, or a base64 string representation of the same.
---@param name string
---@param base64Text string
---@return nil
function SoundAPI:addSound(name, base64Text) end
