vanilla_model.ALL:setVisible(false)
vanilla_model.HELD_ITEMS:setVisible(true)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.PARROTS:setVisible(true)

-- pony stuff
local initValues = require("initValues")
for k, v in pairs(initValues) do
    if config:load(k) == nil then
        config:save(k, v)
    end
end

Horn = config:load("Horn")
Magic = config:load("Magic")
Wings = config:load("Wings")

-- ArmorAPI
local kattArmor = require("kattArmor")

local modelsponyRoot = models.pony.Root

kattArmor.Armor.Helmet:addParts(
    modelsponyRoot.body.neck.head.Helmet,
    modelsponyRoot.body.neck.head.Helmet_snout
)
kattArmor.Armor.Chestplate:addParts(
    modelsponyRoot.body.Chestplate,
    modelsponyRoot.body.neck.Neckpiece
)
kattArmor.Armor.Leggings:addParts(
    modelsponyRoot.left_back_leg.Leggings,
    modelsponyRoot.right_back_leg.Leggings
)
kattArmor.Armor.Leggings:setLayer(1)
kattArmor.Armor.Boots:addParts(
    modelsponyRoot.left_front_leg.Boots,
    modelsponyRoot.right_front_leg.Boots,
    modelsponyRoot.left_back_leg.Boots,
    modelsponyRoot.right_back_leg.Boots
)

if textures["Textures.leather"] ~= nil then --find texutre files
    kattArmor.Materials.leather:setTexture(textures["Textures.leather"])
    kattArmor.Materials.chainmail:setTexture(textures["Textures.chainmail"])
    kattArmor.Materials.iron:setTexture(textures["Textures.iron"])
    kattArmor.Materials.golden:setTexture(textures["Textures.gold"])
    kattArmor.Materials.diamond:setTexture(textures["Textures.diamond"])
    kattArmor.Materials.netherite:setTexture(textures["Textures.netherite"])
    kattArmor.Materials.turtle:setTexture(textures["Textures.turtle"])
    kattArmor.Materials.copper_diving:setTexture(textures["Textures.copperdiving"])
    kattArmor.Materials.netherite_diving:setTexture(textures["Textures.netheritediving"])
elseif textures["pony.leather"] ~= nil then
    kattArmor.Materials.leather:setTexture(textures["pony.leather"])
    kattArmor.Materials.chainmail:setTexture(textures["pony.chainmail"])
    kattArmor.Materials.iron:setTexture(textures["pony.iron"])
    kattArmor.Materials.golden:setTexture(textures["pony.gold"])
    kattArmor.Materials.diamond:setTexture(textures["pony.diamond"])
    kattArmor.Materials.netherite:setTexture(textures["pony.netherite"])
    kattArmor.Materials.turtle:setTexture(textures["pony.turtle"])
    kattArmor.Materials.copper_diving:setTexture(textures["Textures.copperdiving"])
    kattArmor.Materials.netherite_diving:setTexture(textures["ponys.netheritediving"])
end

kattArmor.Materials.leather:addParts(
    kattArmor.Armor.Helmet, 
    modelsponyRoot.body.neck.head.Helmet_L
)
kattArmor.Materials.leather:addParts(
    kattArmor.Armor.Chestplate, 
    modelsponyRoot.body.Chestplate_L,
    modelsponyRoot.body.neck.Neckpiece_L
)
kattArmor.Materials.leather:addParts(
    kattArmor.Armor.Leggings, 
    modelsponyRoot.left_back_leg.Leggings_L,
    modelsponyRoot.right_back_leg.Leggings_L
)
kattArmor.Materials.leather:addParts(
    kattArmor.Armor.Boots, 
    modelsponyRoot.left_front_leg.Boots_L,
    modelsponyRoot.right_front_leg.Boots_L, 
    modelsponyRoot.left_back_leg.Boots_L,
    modelsponyRoot.right_back_leg.Boots_L
)

kattArmor.Materials[true]:addParts(kattArmor.Armor.Helmet,
    modelsponyRoot.body.neck.head.hair
)

function kattArmor.onChange(partID, part, item, prevItem)
    if item:getName() == ("Copper Backtank") then
        part:setMaterial("copper_diving")
    elseif item:getName() == ("Netherite Backtank") then
        part:setMaterial("netherite_diving")
    else
        part:setMaterial()
    end
end

emote = 0

require("locomotion")
require("actionWheel")
