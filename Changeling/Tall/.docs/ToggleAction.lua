---@diagnostic disable: duplicate-set-field
---An Action that is executed when toggled.
---@class ToggleAction:Action
---@field toggle function Function that is executed when the Action is toggled.
---@field untoggle function Function that is executed when the Action is untoggled.
local ToggleAction={}
---Sets the title of the Action when it is toggled. Returns the Action for function chaining.
---@param title string
---@return ToggleAction
function ToggleAction:toggleTitle(title) end
---Sets the item of the Action when it is toggled. Returns the Action for function chaining.
---@param item ItemStack
---@return ToggleAction
function ToggleAction:toggleItem(item) end
---Sets the item of the Action when it is toggled. Returns the Action for function chaining.
---@param item string
---@return ToggleAction
function ToggleAction:toggleItem(item) end
---Sets the color of the Action when it is toggled. Returns the Action for function chaining.
---@param color Vector3
---@return ToggleAction
function ToggleAction:toggleColor(color) end
---Sets the color of the Action when it is toggled. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ToggleAction
function ToggleAction:toggleColor(r, g, b) end
---Sets the toggle state of the Action. Returns the Action for function chaining.
---@param bool boolean
---@return ToggleAction
function ToggleAction:toggled(bool) end
---Sets the function that is executed when the Action is untoggled. Returns the Action for function chaining.
---@param rightFunction function
---@return ToggleAction
function ToggleAction:onUntoggle(rightFunction) end
---Sets the function that is executed when the Action is toggled. Returns the Action for function chaining.
---@param leftFunction function
---@return ToggleAction
function ToggleAction:onToggle(leftFunction) end
---Gets this Action toggled color.
---@return Vector3
function ToggleAction:getToggleColor() end
---Gets this Action toggled title.
---@return string
function ToggleAction:getToggleTitle() end
---Checks if the Action is toggled or not.
---@return boolean
function ToggleAction:isToggled() end
---Sets the color of the Action. Returns the Action for function chaining.
---@param color Vector3
---@return ToggleAction
function ToggleAction:color(color) end
---Sets the color of the Action. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ToggleAction
function ToggleAction:color(r, g, b) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item ItemStack
---@return ToggleAction
function ToggleAction:item(item) end
---Sets the item of the Action. Returns the Action for function chaining.
---@param item string
---@return ToggleAction
function ToggleAction:item(item) end
---Sets the title of the Action. Returns the Action for function chaining.
---@return ToggleAction
function ToggleAction:title() end
---Sets the title of the Action. Returns the Action for function chaining.
---@param title string
---@return ToggleAction
function ToggleAction:title(title) end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item ItemStack
---@return ToggleAction
function ToggleAction:hoverItem(item) end
---Sets the item of the Action when it is being hovered. Returns the Action for function chaining.
---@param item string
---@return ToggleAction
function ToggleAction:hoverItem(item) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param color Vector3
---@return ToggleAction
function ToggleAction:hoverColor(color) end
---Sets the color of the Action when it is being hovered. Returns the Action for function chaining.
---@param r number
---@param g number
---@param b number
---@return ToggleAction
function ToggleAction:hoverColor(r, g, b) end
---Gets this Action hover color.
---@return Vector3
function ToggleAction:getHoverColor() end
---Gets this Action color.
---@return Vector3
function ToggleAction:getColor() end
