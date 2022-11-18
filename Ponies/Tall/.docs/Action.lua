---@diagnostic disable: duplicate-set-field
---An action in the Figura Action Wheel. An abstract superclass of ClickAction, ToggleAction, and ScrollAction.
---@class Action
local Action={}
---Sets the color of the Action. Returns the Action for function chaining.
---@param color Vector3
---@return Action
function Action:color(color) end
---Sets the color of the Action. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return Action
function Action:color(r, g, b) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item ItemStack
---@return Action
function Action:item(item) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item string
---@return Action
function Action:item(item) end
---Sets the title of the Action. Returns the Action for function chaining.
---@return Action
function Action:title() end
---Sets the title of the Action. Returns the Action for function chaining.
---@param title string
---@return Action
function Action:title(title) end
---Gets this Action title.
---@return string
function Action:getTitle() end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item ItemStack
---@return Action
function Action:hoverItem(item) end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item string
---@return Action
function Action:hoverItem(item) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param color Vector3
---@return Action
function Action:hoverColor(color) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return Action
function Action:hoverColor(r, g, b) end
---Gets this Action hover color.
---@return Vector3
function Action:getHoverColor() end
---Gets this Action color.
---@return Vector3
function Action:getColor() end
