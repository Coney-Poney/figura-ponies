local vel
local magicAttack = false
local pose = ""
local vehicle = nil
local rot = vec(0,0,0)
local lrot = vec(0,0,0)
local isLegsBusy = false

--- Set-Up ---
SM = {
    move = GNA.newStateMachine(),
    legs = GNA.newStateMachine(),
    attack = GNA.newStateMachine(),
    emote = GNA.newStateMachine()
}
Keys = {
    attack = keybind:create("attack", keybind:getVanillaKey("key.attack")),
    interact = keybind:create("interact", keybind:getVanillaKey("key.use"))
}
SM.move.blendTime = 0.18

--- Keys ---
Keys.attack.onPress = function()
    if not action_wheel:isEnabled() then
        pings.attack()
    end
end

function pings.attack()
    if Magic then
        magicAttack = true
    else
        if player:isLeftHanded() then
            SM.attack:setState(animations.pony.Attacking_L, true)
        else
            SM.attack:setState(animations.pony.Attacking_R, true)
        end
    end
end

Keys.attack.onRelease = function()
    pings.atkRelease()
end

function pings.atkRelease()
    if not isLegsBusy then
        SM.attack:setState(nil)
    end
    isLegsBusy = false
    magicAttack = false
end

Keys.interact.onPress = function()
   pings.interact()
end

function pings.interact()
    if not Magic then
        if player:getActiveItem():getUseAction() ~= "NONE" then
            if player:getTargetedBlock(true,5).id ~= "minecraft:air" then
                if player:getHeldItem():getUseAction() == "NONE" then
                    if player:isLeftHanded() then
                        SM.attack:setState(animations.pony.place_L, true)
                    else
                        SM.attack:setState(animations.pony.place_R, true)
                    end
                elseif player:getHeldItem(true):getUseAction() == "NONE" then
                    if not player:isLeftHanded() then
                        SM.attack:setState(animations.pony.place_L, true)
                    else
                        SM.attack:setState(animations.pony.place_R, true)
                    end
                end
            end
        end
    end
end

Keys.interact.onRelease = function ()
    pings.intRelease()
end

function pings.intRelease()
    SM.attack:setState(nil)
end

--- State Machine ---
Jump = GNA.newAnimationGroup()
Jump:addAnimations(animations.pony.Jump,animations.pony.Jump2)

events.TICK:register(function()
    lrot = rot
    rot = vanilla_model.HEAD:getOriginRot()
    vel = player:getVelocity()
    pose = player:getPose()
    vehicle = player:getVehicle()
    local FW = player:isFlying() and not Wings
    local radRot = math.rad(-player:getBodyYaw())
    local localVel = vec(
      (math.cos(radRot) * vel.x) + (math.sin(radRot) * vel.z),
      (math.sin(radRot) * vel.x) + (math.cos(radRot) * vel.z)
    )
    local distance_travel = localVel:length()
    if Magic or player:getActiveItem().id == "minecraft:air" then
        isLegsBusy = false
    elseif player:getActiveItem().id ~= "minecraft:air" then
        if player:getActiveItem().id == "minecraft:bow" then
            if player:isClimbing() then
                SM.legs:setState(animations.pony.bow_reload2)
            else
                SM.legs:setState(animations.pony.bow_reload)
            end
        elseif player:getActiveItem().id == "minecraft:trident" then
            if player:isLeftHanded() then
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.trident_L)
                else
                    SM.legs:setState(animations.pony.trident_R)
                end
            else
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.trident_R)
                else
                    SM.legs:setState(animations.pony.trident_L)
                end
            end
        elseif player:getActiveItem().id == "minecraft:shield" then
            if player:isLeftHanded() then
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.shield_L)
                else
                    SM.legs:setState(animations.pony.shield_R)
                end
            else
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.shield_R)
                else
                    SM.legs:setState(animations.pony.shield_L)
                end
            end
        elseif player:getActiveItem():getUseAction() == "EAT" or "DRINK" then
            if player:isLeftHanded() then
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.eatingL)
                else
                    SM.legs:setState(animations.pony.eatingR)
                end
            else
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.eatingR)
                else
                    SM.legs:setState(animations.pony.eatingL)
                end
            end
        elseif player:getActiveItem():getUseAction() == "SPYGLASS" then
            if player:isLeftHanded() then
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.spyglass_l)
                else
                    SM.legs:setState(animations.pony.spyglass_r)
                end
            else
                if player:getActiveHand() == "MAIN_HAND" then
                    SM.legs:setState(animations.pony.spyglass_r)
                else
                    SM.legs:setState(animations.pony.spyglass_l)
                end
            end
        end
        isLegsBusy = true
    else
        if isLegsBusy then
            SM.legs:setState(nil)
        end
    end

    if vehicle then
        SM.move:setState(animations.pony.Sitting)
    elseif pose == 'SLEEPING' then -- Sleeping
        SM.move:setState(animations.pony.Sleeping)
    else
        if pose == "SWIMMING" then -- Swimming and Crawling
            if player:isWet() then
                if not isLegsBusy then
                    SM.legs:setState(animations.pony.Swimming_Legs)
                end
                SM.move:setState(animations.pony.Swimming)
            else
                if not isLegsBusy then
                    animations.pony.Crawling_Legs:speed(localVel.y * 15)
                    SM.legs:setState(animations.pony.Crawling_Legs)
                end
                animations.pony.Crawling:speed(localVel.y * 15)
                SM.move:setState(animations.pony.Crawling)
            end
        elseif pose == 'FALL_FLYING' then -- Flying
            if vel.y < -0.05 then
                SM.move:setState(animations.pony.FlyingDown)
            else
                SM.move:setState(animations.pony.Flying)
            end
        elseif player:isOnGround() or FW then
            if distance_travel > 0.03 then
                if pose == 'CROUCHING' then -- Sneak Walk
                    if not isLegsBusy then
                        animations.pony.Crouching_Legs:speed(localVel.y * 15)
                        SM.legs:setState(animations.pony.Crouching_Legs)
                    end
                    animations.pony.Crouching:speed(localVel.y * 15)
                    SM.move:setState(animations.pony.Crouching)
                elseif player:isSprinting() then -- Sprinting
                    if FW then
                        if not isLegsBusy then
                            animations.pony.Sprint_Legs:speed(localVel.y * 2)
                            SM.legs:setState(animations.pony.Sprint_Legs)
                        end
                        animations.pony.Sprint:speed(localVel.y * 2)
                    else
                        if not isLegsBusy then
                            animations.pony.Sprint_Legs:speed(localVel.y * 4)
                            SM.legs:setState(animations.pony.Sprint_Legs)
                        end
                        animations.pony.Sprint:speed(localVel.y * 4)
                    end
                    SM.move:setState(animations.pony.Sprint)
                else -- Walking
                    if FW then
                        if not isLegsBusy then
                            animations.pony.Walk_Legs:speed(localVel.y * 4)
                            SM.legs:setState(animations.pony.Walk_Legs)
                        end
                        animations.pony.Walk:speed(localVel.y * 4)
                    else
                        if not isLegsBusy then
                            animations.pony.Walk_Legs:speed(localVel.y * 8)
                            SM.legs:setState(animations.pony.Walk_Legs)
                        end
                        animations.pony.Walk:speed(localVel.y * 8)
                    end
                    SM.move:setState(animations.pony.Walk)
                end
            else
                if pose == 'CROUCHING' then -- Crouch
                    SM.move:setState(animations.pony.Crouch)
                else -- Idle
                    SM.move:setState(animations.pony.Idle)
                end
                if not isLegsBusy then  
                    SM.legs:setState(nil)
                end
            end
        else
            if player:isFlying() then -- Creative Flying with Wings
                SM.move:setState(animations.pony.Float)
            elseif player:isClimbing() then -- Climbing Ladder
                if not isLegsBusy then
                    animations.pony.Crawling_Legs:speed(vel.y * 15)
                    SM.legs:setState(animations.pony.Crawling_Legs)
                end
                animations.pony.Crawling:speed(vel.y * 15)
                SM.move:setState(animations.pony.Crawling)
            else -- Jump/Fall
                if vel.y < -0.1 then
                    SM.move:setState(animations.pony.Fall)
                elseif vel.y > 0 then
                    SM.move:setState(Jump)
                end
                SM.legs:setState(nil)
            end
        end
    end
end)

events.RENDER:register(function(d)
    if player then -- Head Rotation
        local r = vec(math.lerp(lrot.x, rot.x, d), math.lerp(lrot.y, rot.y, d), math.lerp(lrot.z, rot.z, d))
        if pose == "SWIMMING" then
            models.pony.Root.body:setRot(0, 0, 0)
            models.pony.Root.body.neck.head:setRot(50, 0, r.y)
        elseif player:isClimbing() then
            models.pony.Root.body.neck.head:setRot(r.x * 0.9 - 15, r.y, 0)
            models.pony.Root.body:setRot(r.x * 0.1, 0, 0)
        else
            models.pony.Root.body.neck.head:setRot(r.x * 0.9, r.y, 0)
            models.pony.Root.body:setRot(r.x * 0.1, 0, 0)
        end

        models.pony.Root.body.Tail:setRot(vanilla_model.FAKE_CAPE:getOriginRot()) -- Tail Physics

        if player:getActiveItem().id == "minecraft:bow" then -- Bow animation
            if player:isClimbing() then
                models.pony.Root.left_front_leg:offsetRot(r.x * 0.9, 0, -r.y)
                models.pony.Root.right_front_leg:offsetRot(r.x * 0.9, 0, -r.y)
            elseif pose == "SWIMMING" then
                models.pony.Root.left_front_leg:offsetRot(0, r.y, 0)
                models.pony.Root.right_front_leg:offsetRot(0, r.y, 0)

            else
                models.pony.Root.left_front_leg:offsetRot(r.x * 0.9, r.y, 0)
                models.pony.Root.right_front_leg:offsetRot(r.x * 0.9, r.y, 0)
            end
        else
            models.pony.Root.left_front_leg:offsetRot(0, 0, 0)
            models.pony.Root.right_front_leg:offsetRot(0, 0, 0)
        end
    end
end)

--- Pony Stuff ---

function magicAura() -- Detects when holding something
    if player:getActiveItem().id == ("minecraft:bow" or "minecraft:crossbow") then
        models.pony.LeftArm:setVisible(true)
        models.pony.RightArm:setVisible(true)
    else
        if player:isLeftHanded() then
            if player:getHeldItem().id ~= "minecraft:air" or magicAttack then
                models.pony.LeftArm:setVisible(true)
            else
                models.pony.LeftArm:setVisible(false)
            end
            if player:getHeldItem(true).id ~= "minecraft:air" then
                models.pony.RightArm:setVisible(true)
            else
                models.pony.RightArm:setVisible(false)
            end
        else
            if player:getHeldItem(true).id ~= "minecraft:air" then
                models.pony.LeftArm:setVisible(true)
            else
                models.pony.LeftArm:setVisible(false)
            end
            if player:getHeldItem().id ~= "minecraft:air" or magicAttack then
                models.pony.RightArm:setVisible(true)
            else
                models.pony.RightArm:setVisible(false)
            end
        end
    end
    if models.pony.RightArm.RightArm:getVisible() or models.pony.LeftArm.LeftArm:getVisible() then
        models.pony.Root.body.neck.head.horn_glow:setVisible(true)
    else
        models.pony.Root.body.neck.head.horn_glow:setVisible(false)
    end 
end

events.TICK:register(function ()
    if player then
        if Magic then
            magicAura()
            models.pony.Root.right_front_leg.RIGHT_ITEM_PIVOT:setVisible(false)
            models.pony.Root.left_front_leg.LEFT_ITEM_PIVOT:setVisible(false)
            models.pony.Root.body.neck.head.horn:setVisible(true)
        else
            models.pony.RightArm:setVisible(false)
            models.pony.LeftArm:setVisible(false)
            models.pony.Root.right_front_leg.RIGHT_ITEM_PIVOT:setVisible(true)
            models.pony.Root.left_front_leg.LEFT_ITEM_PIVOT:setVisible(true)
            models.pony.Root.body.neck.head.horn:setVisible(false)
        end

        if Wings then
            models.pony.Root.body.left_wing:setVisible(true)
            models.pony.Root.body.right_wing:setVisible(true)
            models.pony.Root.body.left_wing:setUVPixels(0, 0)
            models.pony.Root.body.right_wing:setUVPixels(0, 0)
        else
            models.pony.Root.body.left_wing:setUVPixels(0, 14)
            models.pony.Root.body.right_wing:setUVPixels(0, 14)
            if player:getItem(5).id ~= "minecraft.air" and player:getItem(5).id == "minecraft:elytra" then
                models.pony.Root.body.left_wing:setVisible(true)
                models.pony.Root.body.right_wing:setVisible(true)
            else
                models.pony.Root.body.left_wing:setVisible(false)
                models.pony.Root.body.right_wing:setVisible(false)
            end
        end
    end
end)

--- Action Wheel ---

rootPage = action_wheel:createPage()

local toggle = rootPage:newAction()
local elytraTexture = false
toggle:title("Toggle Wings")
toggle:item("minecraft:elytra")
if Wings then
    toggle:onToggle(function()
        Wings = false
        print("Disabled Wings!")
    end)
    toggle:onUntoggle(function()
        Wings = true
        print("Enabled Wings!")
    end)
else
    toggle:onUntoggle(function()
        Wings = false
        print("Disabled Wings!")
    end)
    toggle:onToggle(function()
        Wings = true
        print("Enabled Wings!")
    end)
end

local toggle = rootPage:newAction()
toggle:title("Toggle Horn/Magic")
toggle:item("minecraft:end_rod")
if Magic then
    toggle:onToggle(function()
        Magic = false
        models.pony.Root.body.neck.head.horn_glow:setVisible(false)
        print("Disabled Magic!")
    end)
    toggle:onUntoggle(function()
        Magic = true
        models.pony.Root.body.neck.head.horn_glow:setVisible(true)
        print("Enabled Magic!")
    end)
else
    toggle:onUntoggle(function() 
        Magic = false
        models.pony.Root.body.neck.head.horn_glow:setVisible(false)
        print("Disabled Magic!")
    end)
    toggle:onToggle(function() 
        Magic = true
        models.pony.Root.body.neck.head.horn_glow:setVisible(true)
        print("Enabled Magic!")
    end)
end

