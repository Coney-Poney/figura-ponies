---@diagnostic disable: duplicate-set-field
---A task for rendering some Text.
---@class TextTask:RenderTask
local TextTask={}
---Sets the Text for this task render.
---@param text string
---@return TextTask
function TextTask:text(text) end
---Toggles if the Text should render with a drop shadow. Not compatible with "Outline" mode
---@param shadow boolean
---@return TextTask
function TextTask:shadow(shadow) end
---Toggles if the Text should render with a outline. Always renders at full bright. Not compatible with "Shadow" and "Emissive" modes
---@param outline boolean
---@return TextTask
function TextTask:outline(outline) end
---Sets the outline color this Text should render. Only compatible with "Outline" mode
---@param color Vector3
---@return TextTask
function TextTask:outlineColor(color) end
---Sets the outline color this Text should render. Only compatible with "Outline" mode
---@param r number
---@param g number
---@param b number
---@return TextTask
function TextTask:outlineColor(r, g, b) end
---Checks if this task text has shadow.
---@return boolean
function TextTask:hasShadow() end
---Checks if this task text has outline.
---@return boolean
function TextTask:hasOutline() end
---Checks if this task text will render centred.
---@return boolean
function TextTask:isCentred() end
---Toggles if the Text should render centered on this task pivot point.
---@param centered boolean
---@return TextTask
function TextTask:centered(centered) end
---Gets this tasks text outline color.
---@return Vector3
function TextTask:getOutlineColor() end
---The scale of the task, relative with its attached part.
---@param scale Vector3
---@return TextTask
function TextTask:scale(scale) end
---The scale of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return TextTask
function TextTask:scale(x, y, z) end
---Whether or not this task should be rendered.
---@param bool boolean
---@return TextTask
function TextTask:enabled(bool) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param pos Vector3
---@return TextTask
function TextTask:pos(pos) end
---The position of the task, relative with its attached part. Uses model coordinates.
---@param x number
---@param y number
---@param z number
---@return TextTask
function TextTask:pos(x, y, z) end
---Checks if this task is enabled.
---@return boolean
function TextTask:isEnabled() end
---The rotation of the task, relative with its attached part.
---@param rot Vector3
---@return TextTask
function TextTask:rot(rot) end
---The rotation of the task, relative with its attached part.
---@param x number
---@param y number
---@param z number
---@return TextTask
function TextTask:rot(x, y, z) end
---Whether or not this task should be rendered at full bright.
---@param bool boolean
---@return TextTask
function TextTask:emissive(bool) end
---Checks if this task is emissive.
---@return boolean
function TextTask:isEmissive() end
---Gets this task rotation.
---@return Vector3
function TextTask:getRot() end
---Gets this task position.
---@return Vector3
function TextTask:getPos() end
---Gets this task scale.
---@return Vector3
function TextTask:getScale() end
