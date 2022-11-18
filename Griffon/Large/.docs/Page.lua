---@diagnostic disable: duplicate-set-field
---An Action Wheel container which is used to store up to 8 actions.
---@class Page
local Page={}
---Adds a new Click Action on the selected Page's index. If no index is given it is added in the first available index.
---@return ClickAction
function Page:newAction() end
---Adds a new Click Action on the selected Page's index. If no index is given it is added in the first available index.
---@param index integer
---@return ClickAction
function Page:newAction(index) end
---Adds a new Toggle Action on the selected Page's index. If no index is given it is added in the first available index.
---@return ToggleAction
function Page:newToggle() end
---Adds a new Toggle Action on the selected Page's index. If no index is given it is added in the first available index.
---@param index integer
---@return ToggleAction
function Page:newToggle(index) end
---Sets an Action in the Page's given index.
---@param index integer
---@param action Action
---@return nil
function Page:setAction(index, action) end
---Adds a new Scroll Action on the selected Page's index. If no index is given it is added in the first available index.
---@return ScrollAction
function Page:newScroll() end
---Adds a new Scroll Action on the selected Page's index. If no index is given it is added in the first available index.
---@param index integer
---@return ScrollAction
function Page:newScroll(index) end
---Gets an Action from the Page's given index.
---@param index integer
---@return Action
function Page:getAction(index) end
