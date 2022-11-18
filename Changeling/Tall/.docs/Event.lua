---@diagnostic disable: duplicate-set-field
---A hook for a certain event in Minecraft. You may register functions to one, and those functions will be called when the event occurs.
---@class Event
local Event={}
---Removes all functions with the given name from the event. Returns the number of functions that were removed.
---@param name string
---@return integer
function Event:remove(name) end
---Clears the given event of all its functions.
---@return nil
function Event:clear() end
---Registers the given function to the given event. When the event occurs, the function will be run. Functions are run in the order they were registered. The optional name parameter is used when you wish to later remove a function from the event.
---@param func function
---@return nil
function Event:register(func) end
---Registers the given function to the given event. When the event occurs, the function will be run. Functions are run in the order they were registered. The optional name parameter is used when you wish to later remove a function from the event.
---@param func function
---@param name string
---@return nil
function Event:register(func, name) end
