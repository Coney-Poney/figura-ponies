---@diagnostic disable: duplicate-set-field
---An Action that is executed when the mouse is scrolled.
---@class ScrollAction:Action
---@field scroll function Function that is executed when the mouse is scrolled.
local ScrollAction={}
---Sets the function that is executed when the mouse is scrolled. Returns the Action for function chaining.
---@param scrollFunction function
---@return ScrollAction
function ScrollAction:onScroll(scrollFunction) end
---Sets the color of the Action. Returns the Action for function chaining.
---@param color Vector3
---@return ScrollAction
function ScrollAction:color(color) end
---Sets the color of the Action. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ScrollAction
function ScrollAction:color(r, g, b) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item ItemStack
---@return ScrollAction
function ScrollAction:item(item) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item string
---@return ScrollAction
function ScrollAction:item(item) end
---Sets the title of the Action. Returns the Action for function chaining.
---@return ScrollAction
function ScrollAction:title() end
---Sets the title of the Action. Returns the Action for function chaining.
---@param title string
---@return ScrollAction
function ScrollAction:title(title) end
---Gets this Action title.
---@return string
function ScrollAction:getTitle() end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item ItemStack
---@return ScrollAction
function ScrollAction:hoverItem(item) end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item string
---@return ScrollAction
function ScrollAction:hoverItem(item) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param color Vector3
---@return ScrollAction
function ScrollAction:hoverColor(color) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ScrollAction
function ScrollAction:hoverColor(r, g, b) end
---Gets this Action hover color.
---@return Vector3
function ScrollAction:getHoverColor() end
---Gets this Action color.
---@return Vector3
function ScrollAction:getColor() end
