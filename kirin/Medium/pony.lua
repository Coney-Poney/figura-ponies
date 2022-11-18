vanilla_model.ALL:setVisible(false)
vanilla_model.HELD_ITEMS:setVisible(true)

--pony stuff
Magic = true
Wings = false

Timer = require "TimerAPI"
GNA = require "GNanim"
Evnt = require "KattEventsAPI"

local ArmorAPI = require("KattArmorAPI")

ArmorAPI.Armor.addHelmet(models.pony.Root.body.neck.head.Helmet)
ArmorAPI.Armor.addChestplate(
    models.pony.Root.body.Chestplate,
    models.pony.Root.body.neck.Neckpiece
)
ArmorAPI.Armor.addLeggings(
    models.pony.Root.left_back_leg.Leggings,
    models.pony.Root.right_back_leg.Leggings
)
ArmorAPI.Armor.addBoots(
    models.pony.Root.left_front_leg.Boots,
    models.pony.Root.right_front_leg.Boots,
    models.pony.Root.left_back_leg.Boots,
    models.pony.Root.right_back_leg.Boots
)

ArmorAPI.Meta.setArmorTextureSize(vec(4,2))

ArmorAPI.MaterialProperty.setCustomTexture("leather",vec(1,1))
ArmorAPI.MaterialProperty.setCustomTexture("iron",vec(2,1))
ArmorAPI.MaterialProperty.setCustomTexture("golden",vec(1,2))
ArmorAPI.MaterialProperty.setCustomTexture("diamond",vec(2,2))
ArmorAPI.MaterialProperty.setCustomTexture("netherite",vec(3,1))
ArmorAPI.MaterialProperty.setCustomTexture("chainmail",vec(4,1))
ArmorAPI.MaterialProperty.setCustomTexture("turtle",vec(3,2))

do
  local leatherStrips = {
    helmet = {
      models.pony.Root.body.neck.head.Helmet_L
    },
    chestplate = {
      models.pony.Root.body.Chestplate_L,
      models.pony.Root.body.neck.Neckpiece_L
    },
    leggings = {
      models.pony.Root.left_back_leg.Leggings_L,
      models.pony.Root.right_back_leg.Leggings_L
    },
    boots = {
      models.pony.Root.left_front_leg.Boots_L,
      models.pony.Root.right_front_leg.Boots_L,
      models.pony.Root.left_back_leg.Boots_L,
      models.pony.Root.right_back_leg.Boots_L
    }
  }
  ArmorAPI.Events.onChange:register(function(eventArgs)
    if leatherStrips[eventArgs.armorPart] then
      local enabled = eventArgs.armorMaterial == "leather" and eventArgs.isVisible
      for _, parts in pairs(leatherStrips[eventArgs.armorPart]) do
        parts:setVisible(enabled and nil)
      end
    end
  end)
  ArmorAPI.Events.onChange:register(function(eventArgs)
    if eventArgs.armorPart == "helmet" then
      local enabled = not eventArgs.isArmor and eventArgs.isVisible
      models.pony.Root.body.neck.head.hair:setVisible(enabled and nil)
    end
  end)
end

require "SM"
Emote = require "emote"
require "action_wheel"