--TOGGLES--
local toggle = action_wheel:newPage()

toggle:newAction()
:title("Toggle Wings")
:item("minecraft:elytra")
:onToggle(function () pings.Wings() end)
function pings.Wings()
    if Wings then
        Wings = false
    else
        Wings = true
    end
end

toggle:newAction()
:title("Toggle Horn")
:item("minecraft:end_rod")
:onToggle(function () pings.Horn() end)
function pings.Horn()
    if models.pony.Root.body.neck.head.horn:getVisible() then
        models.pony.Root.body.neck.head.horn:setVisible(false)
    else
        models.pony.Root.body.neck.head.horn:setVisible(true)
    end
end

toggle:newAction()
:title("Toggle Magic")
:item("minecraft:nether_star")
:onToggle(function () pings.Magic() end)
function pings.Magic()
    if Magic then
        Magic = false
        models.pony.Root.body.neck.head.horn_glow:setVisible(false)
    else
        Magic = true
    end
end

--EMOTES--
local emotes = action_wheel:newPage()

emotes:newAction()
:title("Yee-Haw")
:item("minecraft:lead")
:onLeftClick(function ()
    pings.Yee_Haw()
end)
function pings.Yee_Haw()
    if emote == 1 then
        emote = 0
    else
        emote = 1
    end
end

emotes:newAction()
:title("Sit")
:item("minecraft:oak_stairs")
:onLeftClick(function ()
    pings.sit()
end)
function pings.sit()
    if emote == 2 then
        emote = 0
    else
        emote = 2
    end
end

emotes:newAction()
:title("Dance")
:item("minecraft:music_disc_blocks ")
:onLeftClick(function ()
    pings.dance()
end)
function pings.dance()
    if emote == 3 then
        emote = 0
    else
        emote = 3
    end
end

--ROOT--
local rootPage = action_wheel:newPage()

rootPage:newAction()
:title("Toggles")
:item("minecraft:stone_button")
:onLeftClick(function ()
    action_wheel:setPage(toggle)
end)

rootPage:newAction()
:title("Emotes")
:item("minecraft:jukebox")
:onLeftClick(function ()
    action_wheel:setPage(emotes)
end)

events.TICK:register(function()
    if not action_wheel:isEnabled() then
       action_wheel:setPage(rootPage)
    end
end)

action_wheel:setPage(rootPage)