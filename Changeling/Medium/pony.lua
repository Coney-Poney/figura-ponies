vanilla_model.ALL:setVisible(false)
vanilla_model.HELD_ITEMS:setVisible(true)
vanilla_model.HELMET_ITEM:setVisible(true)

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

KCT.assignTextureToMaterial("leather",textures:getTextures()[4])
KCT.assignTextureToMaterial("chainmail",textures:getTextures()[8])
KCT.assignTextureToMaterial("iron",textures:getTextures()[7])
KCT.assignTextureToMaterial("golden",textures:getTextures()[1])
KCT.assignTextureToMaterial("diamond",textures:getTextures()[2])
KCT.assignTextureToMaterial("netherite",textures:getTextures()[9])
KCT.assignTextureToMaterial("turtle",textures:getTextures()[5])

KCM.addModelPartToMaterial("HELMET","leather",models.pony.Root.body.neck.head.Helmet_L)
KCM.addModelPartToMaterial("CHESTPLATE","leather",models.pony.Root.body.Chestplate_L,models.pony.Root.body.neck.Neckpiece_L)
KCM.addModelPartToMaterial("LEGGINGS","leather",models.pony.Root.left_back_leg.Leggings_L,models.pony.Root.right_back_leg.Leggings_L)
KCM.addModelPartToMaterial("BOOTS","leather",models.pony.Root.left_front_leg.Boots_L,models.pony.Root.right_front_leg.Boots_L,models.pony.Root.left_back_leg.Boots_L,models.pony.Root.right_back_leg.Boots_L)
KCM.addModelPartToMaterial("HELMET",false,models.pony.Root.body.neck.head.hair)

emote = 0


require("locomotion")
require("actionwheel")