vanilla_model.ALL:setVisible(false)
vanilla_model.HELD_ITEMS:setVisible(true)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.PARROTS:setVisible(true)

-- pony stuff
local initvalues = require("InitValues")
for k,v in pairs(initvalues) do
	if config:load(k) == nil then
		config:save(k, v)
	end
end

Horn = config:load("Horn")
Magic = config:load("Magic")
Wings = config:load("Wings")

-- ArmorAPI
local ArmorAPI = require("KattArmorAPI")
local KCT = require("KattArmorCustomTextures")
local KCM = require("KattArmorCustomModel")

local modelsponyRoot = models.pony.Root

ArmorAPI.addHelmet(modelsponyRoot.body.neck.head.Helmet,models.pony.Root.body.neck.head.Helmet_snout)
ArmorAPI.addChestplate(
    modelsponyRoot.body.Chestplate,
    modelsponyRoot.body.neck.Neckpiece
)
ArmorAPI.addLeggings(
    modelsponyRoot.left_back_leg.Leggings,
    modelsponyRoot.right_back_leg.Leggings
)
ArmorAPI.addBoots(
    modelsponyRoot.left_front_leg.Boots,
    modelsponyRoot.right_front_leg.Boots,
    modelsponyRoot.left_back_leg.Boots,
    modelsponyRoot.right_back_leg.Boots
)

if textures["Textures.leather"] ~= nil then --find texutre files
    KCT.assignTextureToMaterial("leather",textures["Textures.leather"])
    KCT.assignTextureToMaterial("chainmail",textures["Textures.chainmail"])
    KCT.assignTextureToMaterial("iron",textures["Textures.iron"])
    KCT.assignTextureToMaterial("golden",textures["Textures.gold"])
    KCT.assignTextureToMaterial("diamond",textures["Textures.diamond"])
    KCT.assignTextureToMaterial("netherite",textures["Textures.netherite"])
    KCT.assignTextureToMaterial("turtle",textures["Textures.turtle"])
elseif textures["pony.leather"] ~= nil then
    KCT.assignTextureToMaterial("leather",textures["pony.leather"])
    KCT.assignTextureToMaterial("chainmail",textures["pony.chainmail"])
    KCT.assignTextureToMaterial("iron",textures["pony.iron"])
    KCT.assignTextureToMaterial("golden",textures["pony.gold"])
    KCT.assignTextureToMaterial("diamond",textures["pony.diamond"])
    KCT.assignTextureToMaterial("netherite",textures["pony.netherite"])
    KCT.assignTextureToMaterial("turtle",textures["pony.turtle"])
end

KCM.addModelPartToMaterial("HELMET","leather",modelsponyRoot.body.neck.head.Helmet_L)
KCM.addModelPartToMaterial("CHESTPLATE","leather",modelsponyRoot.body.Chestplate_L,modelsponyRoot.body.neck.Neckpiece_L)
KCM.addModelPartToMaterial("LEGGINGS","leather",modelsponyRoot.left_back_leg.Leggings_L,modelsponyRoot.right_back_leg.Leggings_L)
KCM.addModelPartToMaterial("BOOTS","leather",modelsponyRoot.left_front_leg.Boots_L,modelsponyRoot.right_front_leg.Boots_L,modelsponyRoot.left_back_leg.Boots_L,modelsponyRoot.right_back_leg.Boots_L)
KCM.addModelPartToMaterial("HELMET",false,modelsponyRoot.body.neck.head.hair)

emote = 0

require("locomotion")
require("actionwheel")
