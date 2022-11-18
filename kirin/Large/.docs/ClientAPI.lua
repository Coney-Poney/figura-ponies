---@diagnostic disable: duplicate-set-field
---A global API used to interact with the current Minecraft client. Most of its functions return things that can be found in the F3 menu.
---@class ClientAPI
local ClientAPI={}
---Returns the "version" of your client. In testing, this returned "Fabric".
---@return string
function ClientAPI.getVersion() end
---Returns the size of the window in Minecraft's interal GUI units.
---@return Vector2
function ClientAPI.getScaledWindowSize() end
---Returns true if the F3 screen is currently open.
---@return boolean
function ClientAPI.isDebugOverlayEnabled() end
---Returns a string containing information about the loaded entities on the client. This string appears in the F3 menu.
---@return string
function ClientAPI.getEntityStatistics() end
---Returns the position of the viewer's camera.
---@return Vector3
function ClientAPI.getCameraPos() end
---Returns the rotation of the viewer's camera.
---@return Vector3
function ClientAPI.getCameraRot() end
---Returns the path to the currently applied shader, used when spectating an entity that has different vision than normal. Normally returns nil.
---@return string
function ClientAPI.getCurrentEffect() end
---Returns your current Java version you're playing Minecraft with.
---@return string
function ClientAPI.getJavaVersion() end
---Returns the type of server you're on. In singleplayer, this is "Integrated".
---@return string
function ClientAPI.getServerBrand() end
---Returns the "version type" of your client. In testing, this returned "Fabric".
---@return string
function ClientAPI.getVersionType() end
---Returns the maximum amount of memory that Minecraft can possibly use.
---@return integer
function ClientAPI.getAllocatedMemory() end
---Returns true if the Minecraft window is currently focused.
---@return boolean
function ClientAPI.isWindowFocused() end
---Returns the number of currently loaded entities.
---@return integer
function ClientAPI.getEntityCount() end
---Returns the number of bytes of memory Minecraft is currently using.
---@return integer
function ClientAPI.getUsedMemory() end
---Checks if the client has the Iris mod installed.
---@return boolean
function ClientAPI.hasIris() end
---Returns true if the hud is enabled (F1 disables the HUD).
---@return boolean
function ClientAPI.isHudEnabled() end
---Gets the FPS of the client. Returns 0 if the fps counter isn't ready yet (or if your pc is just that bad).
---@return integer
function ClientAPI.getFPS() end
---Returns true if the client is paused.
---@return boolean
function ClientAPI.isPaused() end
---Returns a string containing information about the player's chunk. This string appears in the F3 menu.
---@return string
function ClientAPI.getChunkStatistics() end
---Returns a string containing information about the currently playing sounds on the client. This string appears in the F3 menu.
---@return string
function ClientAPI.getSoundStatistics() end
---Returns the maximum amount of memory that Minecraft will try to use.
---@return integer
function ClientAPI.getMaxMemory() end
---Returns the number of currently loaded particles.
---@return string
function ClientAPI.getParticleCount() end
---Gets the FPS string of the client, displayed in the F3 menu. Contains info on the fps, the fps limit, vsync, cloud types, and biome blend radius.
---@return string
function ClientAPI.getFPSString() end
---Compares two versions if they are less than (-1), equals (0) or greater than (1).
---@param version1 string
---@param version2 string
---@return integer
function ClientAPI.compareVersions(version1, version2) end
---Returns the position of the mouse in pixels, relative to the top-left corner.
---@return Vector2
function ClientAPI.getMousePos() end
---Gets the client Figura version.
---@return string
function ClientAPI.getFiguraVersion() end
---Checks if the client is currently using an Iris shader.
---@return boolean
function ClientAPI.hasIrisShader() end
---Returns a string representation of the current game language.
---@return string
function ClientAPI.getActiveLang() end
---Returns the current system time in milliseconds.
---@return integer
function ClientAPI.getSystemTime() end
---Returns the height of the given text in pixels.
---@param text string
---@return integer
function ClientAPI.getTextHeight(text) end
---Returns the size of the Minecraft window in pixels, as {width, height}.
---@return Vector2
function ClientAPI.getWindowSize() end
---Returns the current FOV option of the client, not including additional effects such as speed or sprinting.
---@return number
function ClientAPI.getFOV() end
---Returns the current value of your Gui Scale setting. If you use auto, then it gets the actual current scale.
---@return number
function ClientAPI.getGuiScale() end
---Returns the width of the given text in pixels. In case of multiple lines, return the largest width of all lines
---@param text string
---@return integer
function ClientAPI.getTextWidth(text) end
