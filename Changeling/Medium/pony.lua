vanilla_model.ALL:setVisible(false)
vanilla_model.HELD_ITEMS:setVisible(true)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.PARROTS:setVisible(true)

-- pony stuff
Magic = true
Wings = true

-- ArmorAPI
local ArmorAPI = require("KattArmorAPI")
local KCT = require("KattArmorCustomTextures")
local KCM = require("KattArmorCustomModel")

ArmorAPI.addHelmet(models.pony.Root.body.neck.head.Helmet)
ArmorAPI.addChestplate(
    models.pony.Root.body.Chestplate,
    models.pony.Root.body.neck.Neckpiece
)
ArmorAPI.addLeggings(
    models.pony.Root.left_back_leg.Leggings,
    models.pony.Root.right_back_leg.Leggings
)
ArmorAPI.addBoots(
    models.pony.Root.left_front_leg.Boots,
    models.pony.Root.right_front_leg.Boots,
    models.pony.Root.left_back_leg.Boots,
    models.pony.Root.right_back_leg.Boots
)

KCT.assignTextureToMaterial("leather",textures["Textures.leather"] or textures["pony.leather"])
KCT.assignTextureToMaterial("chainmail",textures["Textures.chainmail"] or textures["pony.chainmail"])
KCT.assignTextureToMaterial("iron",textures["Textures.iron"] or textures["pony.iron"])
KCT.assignTextureToMaterial("golden",textures["Textures.gold"] or textures["pony.gold"])
KCT.assignTextureToMaterial("diamond",textures["Textures.diamond"] or textures["pony.diamond"])
KCT.assignTextureToMaterial("netherite",textures["Textures.netherite"] or textures["pony.netherite"])
KCT.assignTextureToMaterial("turtle",textures["Textures.turtle"] or textures["pony.turtle"])

KCM.addModelPartToMaterial("HELMET","leather",models.pony.Root.body.neck.head.Helmet_L)
KCM.addModelPartToMaterial("CHESTPLATE","leather",models.pony.Root.body.Chestplate_L,models.pony.Root.body.neck.Neckpiece_L)
KCM.addModelPartToMaterial("LEGGINGS","leather",models.pony.Root.left_back_leg.Leggings_L,models.pony.Root.right_back_leg.Leggings_L)
KCM.addModelPartToMaterial("BOOTS","leather",models.pony.Root.left_front_leg.Boots_L,models.pony.Root.right_front_leg.Boots_L,models.pony.Root.left_back_leg.Boots_L,models.pony.Root.right_back_leg.Boots_L)
KCM.addModelPartToMaterial("HELMET",false,models.pony.Root.body.neck.head.hair)

emote = 0


require("locomotion")
require("actionwheel")