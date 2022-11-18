---@diagnostic disable: duplicate-set-field
---A global API dedicated to specifically the host of the avatar. For other viewers, these do nothing.
---@class HostAPI
---@field unlockCursor boolean Setting this value to true will unlock your cursor, letting you move it freely on the screen instead of it controlling your player's rotation.
local HostAPI={}
---Gets an ItemStack for the item in the given slot. Should use the same syntax for slots as the /item command.
---@param slot string
---@return ItemStack
function HostAPI:getSlot(slot) end
---Sets the current title to the given text. The text is given as json.
---@param text string
---@return nil
function HostAPI:setTitle(text) end
---Sends the given message in the chat.
---@param message string
---@return nil
function HostAPI:sendChatMessage(message) end
---Appends the message on the recent chat history.
---@param message string
---@return nil
function HostAPI:appendChatHistory(message) end
---Animates swinging the player's arm. If the boolean is true, then the offhand is the one that swings.
---@return nil
function HostAPI:swingArm() end
---Animates swinging the player's arm. If the boolean is true, then the offhand is the one that swings.
---@param offhand boolean
---@return nil
function HostAPI:swingArm(offhand) end
---Gets the chat window text color.
---@return integer
function HostAPI:getChatColor() end
---Gets the text that is currently being typed into the chat window.
---@return string
function HostAPI:getChatText() end
---Sets the action bar message to the given text. The boolean parameter defaults to false.
---@param text string
---@return nil
function HostAPI:setActionbar(text) end
---Sets the action bar message to the given text. The boolean parameter defaults to false.
---@param text string
---@param animated boolean
---@return nil
function HostAPI:setActionbar(text, animated) end
---Checks if the host has a container screen opened.
---@return boolean
function HostAPI:isContainerOpen() end
---Checks if the host has the chat screen opened.
---@return boolean
function HostAPI:isChatOpen() end
---Sends the given command in the chat.
---@param command string
---@return nil
function HostAPI:sendChatCommand(command) end
---Sets the color of the text that is currently being typed into the chat window.
---@param color Vector3
---@return nil
function HostAPI:setChatColor(color) end
---Sets the color of the text that is currently being typed into the chat window.
---@param r number
---@param g number
---@param b number
---@return nil
function HostAPI:setChatColor(r, g, b) end
---Gets the class name of the screen the player is currently on. If the player is not currently in a screen, returns nil.
---@return string
function HostAPI:getScreen() end
---Sets the text currently being typed in the chat window to the given string.
---@param text string
---@return nil
function HostAPI:setChatText(text) end
---Returns true if this instance of the script is running on host.
---@return boolean
function HostAPI:isHost() end
---Clears the current title from the GUI.
---@return nil
function HostAPI:clearTitle() end
---Sets the duration of the title on the screen, also its fade-in and fade-out durations.
---@param timesData Vector3
---@return nil
function HostAPI:setTitleTimes(timesData) end
---Sets the duration of the title on the screen, also its fade-in and fade-out durations.
---@param fadeInTime integer
---@param stayTime integer
---@param fadeOutTime integer
---@return nil
function HostAPI:setTitleTimes(fadeInTime, stayTime, fadeOutTime) end
---Returns a proxy for your currently targeted entity. This entity appears on the F3 screen.
---@return EntityAPI
function HostAPI:getTargetedEntity() end
---Sets the current subtitle to the given text. The text is given as json.
---@param text string
---@return nil
function HostAPI:setSubtitle(text) end
