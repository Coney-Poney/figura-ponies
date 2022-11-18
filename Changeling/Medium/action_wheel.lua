if not host:isHost() then return end

local awTree = {
   {
      name="Emotes",
      item="apple",
      page = Emote.emotePage
   },
   {
      name="Toggles",
      item="stone_button",
      page=rootPage
   }
}

local root = action_wheel:createPage()

for key, value in pairs(awTree) do
   root:newAction():title(value.name):item(value.item).leftClick = function ()
      action_wheel:setPage(value.page)
   end
end

events.TICK:register(function()
   if not action_wheel:isEnabled() then
      action_wheel:setPage(root)
   end
end)

action_wheel:setPage(root)