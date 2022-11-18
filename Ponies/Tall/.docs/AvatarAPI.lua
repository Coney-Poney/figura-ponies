---@diagnostic disable: duplicate-set-field
---A global API containing functions to interact with your avatar's metadata, and also to get information about the current script environment.
---@class AvatarAPI
local AvatarAPI={}
---Gets the name string of this avatar.
---@return string
function AvatarAPI:getName() end
---Store the given key-value pair inside your current avatar's metadata. Someone else can get this information from a different script with the playerVars() function in World. The key must be a string.
---@param key string
---@param value any
---@return nil
function AvatarAPI:store(key, value) end
---Gets the file size of this avatar in bytes.
---@return number
function AvatarAPI:getSize() end
---Sets the current color string of your avatar, used as your avatar theme.
---@param color Vector3
---@return nil
function AvatarAPI:setColor(color) end
---Sets the current color string of your avatar, used as your avatar theme.
---@param r number
---@param g number
---@param b number
---@return nil
function AvatarAPI:setColor(r, g, b) end
---Gets the version string of this avatar.
---@return string
function AvatarAPI:getVersion() end
---Gets the authors string of this avatar.
---@return string
function AvatarAPI:getAuthors() end
---Gets the maximum allowed instructions in Events.WORLD_RENDER and Events.POST_WORLD_RENDER in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxWorldRenderCount() end
---Gets the number of Events.WORLD_RENDER and Events.POST_WORLD_RENDER instructions of this avatar last frame.
---@return integer
function AvatarAPI:getWorldRenderCount() end
---Gets the remaining amount of particles this avatar can summon.
---@return integer
function AvatarAPI:getRemainingParticles() end
---Gets the current animation complexity of this avatar.
---@return integer
function AvatarAPI:getAnimationComplexity() end
---Gets the maximum allowed animation complexity (number of playing channels) in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxAnimationComplexity() end
---Gets the current number of instructions that have been executed by your avatar. Resets to 0 at the beginning of certain events.
---@return integer
function AvatarAPI:getCurrentInstructions() end
---Gets the maximum allowed instructions in Events.WORLD_TICK in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxWorldTickCount() end
---Gets whether or not the viewer allows your avatar to edit the vanilla models.
---@return boolean
function AvatarAPI:canEditVanillaModel() end
---Gets the maximum allowed instructions in Events.RENDER and Events.POST_RENDER in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxRenderCount() end
---Gets the number of Events.WORLD_TICK instructions of this avatar last tick.
---@return integer
function AvatarAPI:getWorldTickCount() end
---Gets the number of initialization instructions of this avatar.
---@return integer
function AvatarAPI:getInitCount() end
---Gets whether this script currently has stopped due to an error (kinda useless lmao).
---@return boolean
function AvatarAPI:hasScriptError() end
---Gets the number of Events.ENTITY_INIT instructions of this avatar.
---@return integer
function AvatarAPI:getEntityInitCount() end
---Gets the maximum allowed instructions during initialization in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxInitCount() end
---Gets the number of Events.TICK instructions of this avatar last tick.
---@return integer
function AvatarAPI:getTickCount() end
---Gets whether or not this avatar has a texture.
---@return boolean
function AvatarAPI:hasTexture() end
---Gets the maximum allowed instructions in Events.TICK in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxTickCount() end
---Gets the number of Events.RENDER and Events.POST_RENDER instructions of this avatar last frame.
---@return integer
function AvatarAPI:getRenderCount() end
---Gets the remaining amount of sound this avatar can play.
---@return integer
function AvatarAPI:getRemainingSounds() end
---Gets whether or not the viewer allows your avatar to play custom sounds.
---@return boolean
function AvatarAPI:canUseCustomSounds() end
---Gets the maximum allowed number of sounds in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxSounds() end
---Gets the maximum allowed model complexity (number of faces) in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxComplexity() end
---Gets whether or not the viewer allows your avatar to edit your nameplate.
---@return boolean
function AvatarAPI:canEditNameplate() end
---Gets whether or not the viewer trusts you to render the avatar off-screen.
---@return boolean
function AvatarAPI:canRenderOffscreen() end
---Gets the maximum allowed number of particles in the trust settings of the viewer.
---@return integer
function AvatarAPI:getMaxParticles() end
---Gets the current complexity of this avatar.
---@return integer
function AvatarAPI:getComplexity() end
---Gets the current color string of your avatar, used as your avatar theme.
---@return string
function AvatarAPI:getColor() end
