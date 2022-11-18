---@diagnostic disable: duplicate-set-field
---Represents a key binding for your script. Instances are obtained using the KeybindAPI's create() function.
---@class Keybind
---@field onPress function A function that runs when the key is pressed down.
---@field onRelease function A function that runs when the key is released.
---@field enabled boolean Toggles if this keybind should be processed or not.
---@field gui boolean Whenever or not this keybind should run when a GUI is open.
---@field override boolean Toggles if this keybind should stop vanilla keys from running.
local Keybind={}
---Gets the name of the keybind, which you set when you created the keybind.
---@return string
function Keybind:getName() end
---Gets the current key for this keybind.
---@return Keybinds
function Keybind:getKey() end
---Checks whether this key is currently set to its default state (not been changed using the keybind menu)
---@return boolean
function Keybind:isDefault() end
---Sets the key for this keybind.
---@param key Keybinds
---@return nil
function Keybind:setKey(key) end
---Gets the name of the current key for this keybind.
---@return string
function Keybind:getKeyName() end
---Gets whether this keybind is currently pressed down.
---@return boolean
function Keybind:isPressed() end
