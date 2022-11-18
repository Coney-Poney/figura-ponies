local e = {
   isEmoting = false,
   currentEmote = 1
}
-->====================[  ]====================<--
local EMOTES = {
   {
      name = "Sitting",
      anims = animations.pony.Sitting_e,
      parts = {},
      item = "oak_stairs",
      proess = nil,
      init = nil,
      toggle=true
   },
   {
      name = "Yee-Haw",
      anims = animations.pony.Yee_Haw,
      parts = {},
      item = "lead",
      proess = nil,
      init = nil,
      toggle=true,
   },
}

if EMOTES[e.currentEmote].parts then
   for _, p in pairs(EMOTES[e.currentEmote].parts) do
      p:setVisible(false)
   end   
end

local emote = action_wheel:createPage()
for i, v in pairs(EMOTES) do
   emote:newAction():title(v.name):item(v.item).leftClick = function ()
      pings.setEmote(i)
   end
end


e.emotePage = emote

function pings.setEmote(id)
   local em = EMOTES[id]
   if id and not e.isEmoting then
      if em.anims then
         SM.emote:setState(em.anims,true)
      end
      if em.toggle then
         e.isEmoting = true
      end
      if em.init then
         em.init()
      end
      e.currentEmote = id
      if em.parts then
         for _, p in pairs(em.parts) do
            p:setVisible(true)
         end
      end
   else
      if EMOTES[e.currentEmote].parts then
         for _, p in pairs(EMOTES[e.currentEmote].parts) do
            p:setVisible(false)
         end
      end
      e.isEmoting = false
      SM.emote:setState(nil)
   end
end

events.TICK:register(function()
   if e.isEmoting then
      if EMOTES[e.currentEmote].process then
         EMOTES[e.currentEmote].process()
      end
   end
end)

return e
