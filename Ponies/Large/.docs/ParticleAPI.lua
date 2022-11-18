---@diagnostic disable: duplicate-set-field
---A global API which is used for dealing with Minecraft's particles. Can currently only be used to summon a particle. Accessed using the name "particle".
---@class ParticleAPI
local ParticleAPI={}
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param posVel Vector6
---@return nil
function ParticleAPI:addParticle(name, posVel) end
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param pos Vector3
---@return nil
function ParticleAPI:addParticle(name, pos) end
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param pos Vector3
---@param vel Vector3
---@return nil
function ParticleAPI:addParticle(name, pos, vel) end
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param posX number
---@param posY number
---@param posZ number
---@return nil
function ParticleAPI:addParticle(name, posX, posY, posZ) end
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param pos Vector3
---@param velX number
---@param velY number
---@param velZ number
---@return nil
function ParticleAPI:addParticle(name, pos, velX, velY, velZ) end
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param posX number
---@param posY number
---@param posZ number
---@param vel Vector3
---@return nil
function ParticleAPI:addParticle(name, posX, posY, posZ, vel) end
---Creates a particle with the given name at the specified position, with the given velocity. Some particles have special properties, like the "dust" particle. For these particles, the special properties can be put into the "name" parameter, the same way as it works for commands.
---@param name string
---@param posX number
---@param posY number
---@param posZ number
---@param velX number
---@param velY number
---@param velZ number
---@return nil
function ParticleAPI:addParticle(name, posX, posY, posZ, velX, velY, velZ) end
