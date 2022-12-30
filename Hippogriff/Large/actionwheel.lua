--TOGGLES--
local toggle = action_wheel:newPage()

local t = toggle:newAction()
t:title("Toggle Wings")
t:item("minecraft:elytra")
if Wings then
    t:onToggle(function()
        pings.disableWings()
    end)
    t:onUntoggle(function()
        pings.enableWings()
    end)
else
    t:onUntoggle(function()
        pings.disableWings()
    end)
    t:onToggle(function()
        pings.enableWings()
    end)
end
function pings.disableWings()
    Wings = false
    print("Disabled Wings!")
end
function pings.enableWings()
    Wings = true
    print("Enabled Wings!")
end

local t = toggle:newAction()
t:title("Toggle Horn")
t:item("minecraft:end_rod")
if Magic then
    t:onToggle(function()
        pings.disableHorn()
    end)
    t:onUntoggle(function()
        pings.enableHorn()
    end)
else
    t:onUntoggle(function() 
        pings.disableHorn()
    end)
    t:onToggle(function() 
        pings.enableHorn()
    end)
end
function pings.disableHorn()
    Magic = false
    models.pony.Root.body.neck.head.horn:setVisible(false)
    print("Disabled Horn!")
end
function pings.enableHorn()
    Magic = true
    models.pony.Root.body.neck.head.horn:setVisible(true)
    print("Enabled Horn!")
end

local t = toggle:newAction()
t:title("Toggle Magic")
t:item("minecraft:nether_star")
if Magic then
    t:onToggle(function()
        pings.disableMagic()
    end)
    t:onUntoggle(function()
        pings.enableMagic()
    end)
else
    t:onUntoggle(function() 
        pings.disableMagic()
    end)
    t:onToggle(function() 
        pings.enableMagic()
    end)
end
function pings.enableMagic()
    Magic = true
    models.pony.Root.body.neck.head.horn_glow:setVisible(true)
    print("Enabled Magic!")
end
function pings.disableMagic()
    Magic = false
    models.pony.Root.body.neck.head.horn_glow:setVisible(false)
    print("Disabled Magic!")
end

--EMOTES--
local emotes = action_wheel:newPage()

local t = emotes:newAction()
t:title("Yee-Haw")
t:item("minecraft:lead")
t:onLeftClick(function ()
    pings.Yee_Haw()
end)

function pings.Yee_Haw()
    if emote == 1 then
        emote = 0
    else
        emote = 1
    end
end

local t = emotes:newAction()
t:title("Sit")
t:item("minecraft:oak_stairs")
t:onLeftClick(function ()
    pings.sit()
end)

function pings.sit()
    if emote == 2 then
        emote = 0
    else
        emote = 2
    end
end

local t = emotes:newAction()
t:title("Dance")
t:item("minecraft:music_disc_blocks ")
t:onLeftClick(function ()
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

local t = rootPage:newAction()
t:title("Toggles")
t:item("minecraft:stone_button")
t:onLeftClick(function ()
    action_wheel:setPage(toggle)
end)

local t = rootPage:newAction()
t:title("Emotes")
t:item("minecraft:jukebox")
t:onLeftClick(function ()
    action_wheel:setPage(emotes)
end)

events.TICK:register(function()
    if not action_wheel:isEnabled() then
       action_wheel:setPage(rootPage)
    end
end)

action_wheel:setPage(rootPage)