---@diagnostic disable: duplicate-set-field
---A global API which is used for customizing your player's Action Wheel.
---@class ActionWheelAPI
---@field leftClick function Function that is executed when the left mouse button is clicked.
---@field rightClick function Function that is executed when the right mouse button is clicked.
---@field scroll function Function that is executed when the mouse is scrolled.
local ActionWheelAPI={}
---Executes the action of the given index. If the index is null, it will execute the last selected action. A second parameter can be given to specify if it should be executed the left or right action.
---@return nil
function ActionWheelAPI:execute() end
---Executes the action of the given index. If the index is null, it will execute the last selected action. A second parameter can be given to specify if it should be executed the left or right action.
---@param index integer
---@return nil
function ActionWheelAPI:execute(index) end
---Executes the action of the given index. If the index is null, it will execute the last selected action. A second parameter can be given to specify if it should be executed the left or right action.
---@param index integer
---@param rightClick boolean
---@return nil
function ActionWheelAPI:execute(index, rightClick) end
---Returns if the Action Wheel is being currently rendered or not.
---@return boolean
function ActionWheelAPI:isEnabled() end
---Sets the Page of the action wheel to the given Title or Page.
---@param pageTitle string
---@return nil
function ActionWheelAPI:setPage(pageTitle) end
---Sets the Page of the action wheel to the given Title or Page.
---@param page Page
---@return nil
function ActionWheelAPI:setPage(page) end
---Creates a new Page for the action wheel. A Title can be given to store this page internally. If no Title is given, the Page will just be returned from this function.
---@return Page
function ActionWheelAPI:createPage() end
---Creates a new Page for the action wheel. A Title can be given to store this page internally. If no Title is given, the Page will just be returned from this function.
---@param title string
---@return Page
function ActionWheelAPI:createPage(title) end
---Returns the index of the currently selected action.
---@return integer
function ActionWheelAPI:getSelected() end
---Returns the current set Page from the Action Wheel, or NIL if no Page has been set.
---@return Page
function ActionWheelAPI:getCurrentPage() end
---Returns an stored Page by the given title.
---@param pageTitle string
---@return Page
function ActionWheelAPI:getPage(pageTitle) end
