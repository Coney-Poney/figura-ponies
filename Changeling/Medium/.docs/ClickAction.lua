---@diagnostic disable: duplicate-set-field
---An Action that is executed when clicked.
---@class ClickAction:Action
---@field leftClick function Function that is executed when the left mouse button is clicked.
---@field rightClick function Function that is executed when the right mouse button is clicked.
local ClickAction={}
---Sets the function that is executed when the right mouse button is clicked. Returns the Action for function chaining.
---@param rightFunction function
---@return ClickAction
function ClickAction:onRightClick(rightFunction) end
---Sets the function that is executed when the left mouse button is clicked. Returns the Action for function chaining.
---@param leftFunction function
---@return ClickAction
function ClickAction:onLeftClick(leftFunction) end
---Sets the color of the Action. Returns the Action for function chaining.
---@param color Vector3
---@return ClickAction
function ClickAction:color(color) end
---Sets the color of the Action. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ClickAction
function ClickAction:color(r, g, b) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item ItemStack
---@return ClickAction
function ClickAction:item(item) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item string
---@return ClickAction
function ClickAction:item(item) end
---Sets the title of the Action. Returns the Action for function chaining.
---@return ClickAction
function ClickAction:title() end
---Sets the title of the Action. Returns the Action for function chaining.
---@param title string
---@return ClickAction
function ClickAction:title(title) end
---Gets this Action title.
---@return string
function ClickAction:getTitle() end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item ItemStack
---@return ClickAction
function ClickAction:hoverItem(item) end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item string
---@return ClickAction
function ClickAction:hoverItem(item) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param color Vector3
---@return ClickAction
function ClickAction:hoverColor(color) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ClickAction
function ClickAction:hoverColor(r, g, b) end
---Gets this Action hover color.
---@return Vector3
function ClickAction:getHoverColor() end
---Gets this Action color.
---@return Vector3
function ClickAction:getColor() end
