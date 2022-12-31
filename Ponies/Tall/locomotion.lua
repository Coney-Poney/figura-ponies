local vel
local pose = ""
local vehicle = nil
local rot = vec(0,0,0)
local lrot = vec(0,0,0)
local landVel = 0
local hand = false
local rightItem
local leftItem
local rightSwing = false
local leftSwing = false
local wingTexture = false

-- Pony Stuff
function magicAura() -- Detects when holding something
    if player:getActiveItem().id == ("minecraft:bow" or "minecraft:crossbow") then
        models.pony.LeftArm:setVisible(true)
        models.pony.RightArm:setVisible(true)
    else
        if leftItem.id ~= "minecraft:air" or leftSwing then
            models.pony.LeftArm:setVisible(true)
        else
            models.pony.LeftArm:setVisible(false)
        end
        if rightItem.id ~= "minecraft:air" or rightSwing then
            models.pony.RightArm:setVisible(true)
        else
            models.pony.RightArm:setVisible(false)
        end
    end
    if models.pony.RightArm.RightArm:getVisible() or models.pony.LeftArm.LeftArm:getVisible() then
        models.pony.Root.body.neck.head.horn_glow:setVisible(true)
    else
        models.pony.Root.body.neck.head.horn_glow:setVisible(false)
    end 
end

-- Animations
events.TICK:register(function() 
    lrot = rot
    rot = vanilla_model.HEAD:getOriginRot()
    vel = player:getVelocity()
    pose = player:getPose()
    vehicle = player:getVehicle()
    local FlyW = player:isFlying() and Wings
    local radRot = math.rad(-player:getBodyYaw())
    local localVel = vec(
      (math.cos(radRot) * vel.x) + (math.sin(radRot) * vel.z),
      (math.sin(radRot) * vel.x) + (math.cos(radRot) * vel.z)
    )
    local distance_travel = localVel:length()
    local block = world.getBlockState(player:getPos().x,player:getPos().y-0.1,player:getPos().z):toStateString()
    local movingstate = player:isClimbing() or player:isFlying() or vehicle or pose ~= "STANDING" and pose ~= "CROUCHING"
    local freearm = animations.pony.loadingR:getPlayState() == "STOPPED" or animations.pony.bowR:getPlayState() == "STOPPED" or animations.pony.bowL:getPlayState() == "STOPPED" or pose ~= "CROUCHING"
    
    hand = player:isLeftHanded()
    local rightHand = hand and "OFF_HAND" or "MAIN_HAND"
    local leftHand = not hand and "OFF_HAND" or "MAIN_HAND"
    local active = player:getActiveHand()
    local using = player:isUsingItem()
    rightSwing = player:getSwingArm() == rightHand and pose ~= "SLEEPING"
    leftSwing = player:getSwingArm() == leftHand and pose ~= "SLEEPING"
    rightItem = player:getHeldItem(hand)
    leftItem = player:getHeldItem(not hand)
    local usingR = active == rightHand and rightItem:getUseAction()
    local usingL = active == leftHand and leftItem:getUseAction()

    local crossR = rightItem.tag and rightItem.tag["Charged"] == 1 and not Magic
    local crossL = leftItem.tag and leftItem.tag["Charged"] == 1 and not Magic
    local drinkingR = using and usingR == "DRINK" and not Magic
    local drinkingL = using and usingL == "DRINK" and not Magic
    local eatingR = using and usingR == "EAT" and not Magic
    local eatingL = using and usingL == "EAT" and not Magic
    local blockingR = using and usingR == "BLOCK" and not Magic
    local blockingL = using and usingL == "BLOCK" and not Magic
    local bowingR = using and usingR == "BOW" and not Magic
    local bowingL = using and usingL == "BOW" and not Magic
    local spearR = using and usingR == "SPEAR" and not Magic
    local spearL = using and usingL == "SPEAR" and not Magic
    local spyglassR = using and usingR == "SPYGLASS" and not Magic
    local spyglassL = using and usingL == "SPYGLASS" and not Magic
    local hornR = using and usingR == "TOOT_HORN" and not Magic
    local hornL = using and usingL == "TOOT_HORN" and not Magic
    local loadingR = using and usingR == "CROSSBOW" and not Magic
    local loadingL = using and usingL == "CROSSBOW" and not Magic

    animations.pony.drinkingR:setPlaying(drinkingR)
    animations.pony.drinkingL:setPlaying(drinkingL)
    animations.pony.eatingL:setPlaying(eatingL)
    animations.pony.eatingR:setPlaying(eatingR)
    animations.pony.blockingL:setPlaying(blockingL)
    animations.pony.blockingR:setPlaying(blockingR)
    animations.pony.bowR:setPlaying(bowingR)
    animations.pony.bowL:setPlaying(bowingL)
    animations.pony.spearR:setPlaying(spearR)
    animations.pony.spearL:setPlaying(spearL)
    animations.pony.spyglassR:setPlaying(spyglassR)
    animations.pony.spyglassL:setPlaying(spyglassL)
    animations.pony.hornR:setPlaying(hornR)
    animations.pony.hornL:setPlaying(hornL)
    animations.pony.loadingR:setPlaying(loadingR)
    animations.pony.loadingL:setPlaying(loadingL)
    animations.pony.crossR:setPlaying(crossR)
    animations.pony.crossL:setPlaying(crossL)
    animations.pony.swingR:setPlaying(rightSwing and not Magic)
    animations.pony.swingL:setPlaying(leftSwing and not Magic)

    if rightItem.id ~= "minecraft:air" and freearm and not Magic then
        models.pony.Root.right_front_leg:offsetRot(15,0,0)
    else
        models.pony.Root.right_front_leg:offsetRot(0,0,0)
    end
    if leftItem.id ~= "minecraft:air" and freearm and not Magic then
            models.pony.Root.left_front_leg:offsetRot(15,0,0)
    else
        models.pony.Root.left_front_leg:offsetRot(0,0,0)
    end

    if not player:isOnGround() then
        landVel = math.clamp(math.map(vel.y, 0, -1, 0, 1.25),0,2)
    end

    if player:isOnGround() and not movingstate then
        animations.pony.jumpup:stop()
        animations.pony.jumpdown:stop()
        if animations.pony.fall:getPlayState() == "PLAYING" then
            animations.pony.fall:stop()
            animations.pony.land:blend(landVel)
            animations.pony.land:play()
        end
        if distance_travel == 0 then
            animations.pony.idle:play()
        else
            animations.pony.idle:stop()
            emote = 0
        end
    else
        emote = 0
        if player:isFlying() then
            animations.pony.jumpup:stop()
        elseif not movingstate then
            if vel.y < 0 and vel.y > -0.375 and animations.pony.jumpup:getPlayState() == "PLAYING" then
                animations.pony.jumpup:stop()
                animations.pony.jumpdown:play()
            elseif vel.y < -0.4 then
                animations.pony.fall:blend(vel.y*-2.5)
                animations.pony.fall:play()
            elseif vel.y > 0.01 then
                animations.pony.jumpup:play()
                animations.pony.jumpdown:stop()
            end
        end
    end

    animations.pony.Yee_Haw:setPlaying(emote == 1)
    animations.pony.dance:setPlaying(emote == 3)
    animations.pony.sit:setPlaying(vehicle or emote == 2)

    animations.pony.crouch:setPlaying(pose == 'CROUCHING' and not player:isClimbing())
    animations.pony.walk:speed(localVel.y * 17.5)
    animations.pony.sprint:speed(localVel.y * 17.5)
    animations.pony.sprint:setPlaying(not movingstate and pose ~= "CROUCHING" and not (blockingL or blockingL) and distance_travel > 0.03 and player:isSprinting() and not (block == "minecraft:soul_sand{}" or block == "minecraft:honey_block{}" or block == "minecraft:slime_block{}") and not FlyW)
    animations.pony.walk:setPlaying(not movingstate and distance_travel > 0.03 and animations.pony.sprint:getPlayState() == "STOPPED" and not FlyW)
    animations.pony.climb:speed(vel.y * 15)
    animations.pony.climb:setPlaying(player:isClimbing() and not player:isOnGround())
    animations.pony.swim:speed(vel:length() * 7)
    animations.pony.swim:setPlaying(not vehicle and pose == "SWIMMING" and player:isUnderwater())
    animations.pony.crawl:speed(localVel.y * 15)
    animations.pony.crawl:setPlaying(not vehicle and pose == "SWIMMING" and not player:isUnderwater())
    animations.pony.hover:setPlaying(player:isFlying() and (Wings or wingTexture))
    animations.pony.flying:setPlaying(pose == "FALL_FLYING" and vel.y > 0 and vel:length() < 1.25)
    animations.pony.flyingdown:setPlaying(pose == "FALL_FLYING" and (vel.y < 0 or vel:length() > 1.25))
    animations.pony.spinattack:setPlaying(pose == "SPIN_ATTACK")
    animations.pony.sleeping:setPlaying(pose == "SLEEPING")
    animations.pony.Dying:setPlaying((player:getHealth() + player:getNbt().AbsorptionAmount) == 0)

    if Magic then
        magicAura()
        models.pony.Root.right_front_leg.RIGHT_ITEM_PIVOT:setVisible(false)
        models.pony.Root.left_front_leg.LEFT_ITEM_PIVOT:setVisible(false)
    else
        models.pony.RightArm:setVisible(false)
        models.pony.LeftArm:setVisible(false)
        models.pony.Root.right_front_leg.RIGHT_ITEM_PIVOT:setVisible(true)
        models.pony.Root.left_front_leg.LEFT_ITEM_PIVOT:setVisible(true)
    end

    if Wings then
        models.pony.Root.body.left_wing:setVisible(true)
        models.pony.Root.body.right_wing:setVisible(true)
        models.pony.Root.body.left_wing:setUVPixels(0, 0)
        models.pony.Root.body.right_wing:setUVPixels(0, 0)
    else
        models.pony.Root.body.left_wing:setUVPixels(0, 14)
        models.pony.Root.body.right_wing:setUVPixels(0, 14)
        if player:getItem(5).id == "minecraft:elytra" then
            wingTexture = true
            models.pony.Root.body.left_wing:setVisible(true)
            models.pony.Root.body.right_wing:setVisible(true)
        else
            wingTexture = false
            models.pony.Root.body.left_wing:setVisible(false)
            models.pony.Root.body.right_wing:setVisible(false)
        end
    end
end)

-- Arm and Head movement
events.RENDER:register(function (t)
    local r = vec(math.lerp(lrot.x, rot.x, t), math.lerp(lrot.y, rot.y, t), math.lerp(lrot.z, rot.z, t))
    if player then
        if pose == "SWIMMING" or pose == "FALL_FLYING" or pose == "SPIN_ATTACK" then
            models.pony.Root:offsetRot(90, 0, 0)
            models.pony.Root:setPos(0,20,-10)
        elseif pose == "SLEEPING" then
            models.pony.Root:offsetRot(-90, 0, 180)
            models.pony.Root:setPos(0,20,7.5)
        else
            models.pony.Root:offsetRot(0,0,0)
            if vehicle then
                models.pony.Root:setPos(0,9,-7)
            elseif pose == 'CROUCHING' then
                models.pony.Root:setPos(0,1,0)
            else
                models.pony.Root:setPos(0,0,0)
            end
        end
        if not Magic then
            if animations.pony.bowL:getPlayState() == "PLAYING" or animations.pony.bowR:getPlayState() == "PLAYING" then
                models.pony.Root.left_front_leg:offsetRot(r.x * 0.9, r.y * 0.5, 0)
                models.pony.Root.right_front_leg:offsetRot(r.x * 0.9, r.y * 0.5, 0)
            elseif animations.pony.crossR:getPlayState() == "PLAYING" or  animations.pony.crossL:getPlayState() == "PLAYING" then
                models.pony.Root.left_front_leg:offsetRot(r.x * 0.9, r.y, 0)
                models.pony.Root.right_front_leg:offsetRot(r.x * 0.9, r.y, 0)
            end
            if animations.pony.spyglassR:getPlayState() == "PLAYING" or animations.pony.hornR:getPlayState() == "PLAYING" or animations.pony.eatingR:getPlayState() == "PLAYING"  or animations.pony.drinkingR:getPlayState() == "PLAYING" then
                models.pony.Root.right_front_leg:offsetRot(r.x * 0.75, r.y * 0.9, 0)
            elseif animations.pony.spyglassL:getPlayState() == "PLAYING" or animations.pony.hornL:getPlayState() == "PLAYING" or animations.pony.eatingL:getPlayState() == "PLAYING" or animations.pony.drinkingL:getPlayState() == "PLAYING" then
                models.pony.Root.left_front_leg:offsetRot(r.x * 0.75, r.y * 0.9, 0)
            end
        end

        models.pony.Root.body.neck.head:setRot(r.x * 0.9, r.y, 0)
        models.pony.Root:setRot(r.x * 0.1, 0, 0)
        models.pony.Root.body.Tail:setRot(vanilla_model.FAKE_CAPE:getOriginRot() + vec(15,0,0))
    end
end)

require("GSAnimBlend")

for key,value in pairs(animations.pony) do
    value:blendTime(1)
end

animations.pony.idle:blendTime(3)
animations.pony.crouch:blendTime(0)
animations.pony.sit:blendTime(0)
animations.pony.walk:blendTime(3)
animations.pony.sprint:blendTime(5)
animations.pony.jumpup:blendTime(3)
animations.pony.jumpdown:blendTime(3)
animations.pony.fall:blendTime(5)
animations.pony.land:blendTime(0)
animations.pony.climb:blendTime(6)
animations.pony.crawl:blendTime(0)
animations.pony.swim:blendTime(0)
animations.pony.flying:blendTime(3)
animations.pony.flyingdown:blendTime(3)