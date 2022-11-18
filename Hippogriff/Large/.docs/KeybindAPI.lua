---@diagnostic disable: duplicate-set-field
---A global API containing a function to create new Keybind instances.
---@class KeybindAPI
local KeybindAPI={}
---Creates and returns a new Keybind. The name is used in the keybind menu. The key parameter is an identifier for a key, such as "key.keyboard.r". The boolean gui indicates whether the keybind should always work, or if it should only work when you don't have a screen open. Check the docs list command for all key names.
---@param name string
---@param key Keybinds
---@return Keybind
function KeybindAPI:create(name, key) end
---Creates and returns a new Keybind. The name is used in the keybind menu. The key parameter is an identifier for a key, such as "key.keyboard.r". The boolean gui indicates whether the keybind should always work, or if it should only work when you don't have a screen open. Check the docs list command for all key names.
---@param name string
---@param key Keybinds
---@param gui boolean
---@return Keybind
function KeybindAPI:create(name, key, gui) end
---Creates and returns a new Keybind. The name is used in the keybind menu. The key parameter is an identifier for a key, such as "key.keyboard.r". The boolean gui indicates whether the keybind should always work, or if it should only work when you don't have a screen open. Check the docs list command for all key names.
---@param name string
---@param key Keybinds
---@param gui boolean
---@param override boolean
---@return Keybind
function KeybindAPI:create(name, key, gui, override) end
---Gets the id of the key bound to the given action, as a string. Check the docs list command for all key names and vanilla actions.
---@param id KeyIDs
---@return Keybinds
function KeybindAPI:getVanillaKey(id) end
