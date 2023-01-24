local vel
local pose = ""
local vehicle = nil
local rot = vec(0,0,0)
local lrot = vec(0,0,0)
local landVel = 0
local wingTexture = false

-- Animations
events.TICK:register(function()
    lrot = rot
    rot = vanilla_model.HEAD:getOriginRot()
    vel = player:getVelocity()
    pose = player:getPose()
    vehicle = player:getVehicle()
    local radRot = math.rad(-player:getBodyYaw())
    local localVel = vec(
      (math.cos(radRot) * vel.x) + (math.sin(radRot) * vel.z),
      (math.sin(radRot) * vel.x) + (math.cos(radRot) * vel.z)
    )
    local distance_travel = localVel:length()
    local block = world.getBlockState(player:getPos().x,player:getPos().y-0.1,player:getPos().z):toStateString()
    local movingstate = player:isClimbing() or player:isFlying() or vehicle or (pose ~= "STANDING" and pose ~= "CROUCHING")
    
    local hand = player:isLeftHanded()
    local rightHand = hand and "OFF_HAND" or "MAIN_HAND"
    local leftHand = not hand and "OFF_HAND" or "MAIN_HAND"
    local active = player:getActiveHand()
    local using = player:isUsingItem()
    local rightSwing = player:getSwingArm() == rightHand and pose ~= "SLEEPING"
    local leftSwing = player:getSwingArm() == leftHand and pose ~= "SLEEPING"
    local rightItem = player:getHeldItem(hand)
    local leftItem = player:getHeldItem(not hand)
    local usingR = active == rightHand and rightItem:getUseAction()
    local usingL = active == leftHand and leftItem:getUseAction()

    crossR = rightItem.tag and rightItem.tag["Charged"] == 1
    crossL = leftItem.tag and leftItem.tag["Charged"] == 1
    drinkingR = using and usingR == "DRINK"
    drinkingL = using and usingL == "DRINK"
    eatingR = using and usingR == "EAT"
    eatingL = using and usingL == "EAT"
    local blockingR = using and usingR == "BLOCK"
    local blockingL = using and usingL == "BLOCK"
    bowingR = using and usingR == "BOW"
    bowingL = using and usingL == "BOW"
    local spearR = using and usingR == "SPEAR"
    local spearL = using and usingL == "SPEAR"
    spyglassR = using and usingR == "SPYGLASS"
    spyglassL = using and usingL == "SPYGLASS"
    hornR = using and usingR == "TOOT_HORN"
    hornL = using and usingL == "TOOT_HORN"
    local loadingR = using and usingR == "CROSSBOW"
    local loadingL = using and usingL == "CROSSBOW"

    if not Magic then
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
        animations.pony.swingR:setPlaying(rightSwing)
        animations.pony.swingL:setPlaying(leftSwing)

        if rightItem.id ~= "minecraft:air" and not (crossL or crossR or bowingL or bowingR or pose == "CROUCHING") then
            models.pony.Root.right_front_leg:offsetRot(15,0,0)
        else
            models.pony.Root.right_front_leg:offsetRot(0,0,0)
        end
        if leftItem.id ~= "minecraft:air" and not (crossL or crossR or bowingL or bowingR or pose == "CROUCHING") then
            models.pony.Root.left_front_leg:offsetRot(15,0,0)
        else
            models.pony.Root.left_front_leg:offsetRot(0,0,0)
        end
    else
        models.pony.Root.left_front_leg:offsetRot(0,0,0)
        models.pony.Root.right_front_leg:offsetRot(0,0,0)
    end

    if not player:isOnGround() then
        landVel = math.clamp(math.map(vel.y, 0, -1, 0, 1.25),0,2)
    end

    if not movingstate then
        if player:isOnGround() then
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
            if vel.y < 0 and vel.y > -0.375 and animations.pony.jumpup:getPlayState() == "PLAYING" then
                animations.pony.jumpdown:play()
            end
        end
    end

    animations.pony.jumpup:setPlaying(not movingstate and not player:isOnGround() and vel.y > 0.0)
    animations.pony.fall:blend(vel.y*-2.5)
    animations.pony.fall:setPlaying(not movingstate and not player:isOnGround() and vel.y < -0.4)

    animations.pony.Yee_Haw:setPlaying(emote == 1)
    animations.pony.dance:setPlaying(emote == 3)
    animations.pony.sit:setPlaying(vehicle or emote == 2)

    animations.pony.crouch:setPlaying(pose == 'CROUCHING' and not player:isClimbing())
    animations.pony.walk:speed(localVel.y * 17.5)
    animations.pony.sprint:speed(localVel.y * 17.5)
    animations.pony.sprint:setPlaying(not movingstate and pose ~= "CROUCHING" and not (blockingL or blockingL) and distance_travel > 0.03 and player:isSprinting() and not (block == "minecraft:soul_sand{}" or block == "minecraft:honey_block{}" or block == "minecraft:slime_block{}"))
    animations.pony.walk:setPlaying(not movingstate and distance_travel > 0.03 and animations.pony.sprint:getPlayState() == "STOPPED")
    animations.pony.climb:speed(vel.y * 15)
    animations.pony.climb:setPlaying(player:isClimbing() and not player:isOnGround())
    animations.pony.swim:speed(vel:length() * 7)
    animations.pony.swim:setPlaying(not vehicle and player:isVisuallySwimming() and player:isUnderwater())
    animations.pony.crawl:speed(localVel.y * 15)
    animations.pony.crawl:setPlaying(not vehicle and player:isVisuallySwimming() and not player:isUnderwater())
    animations.pony.hover:setPlaying(player:isFlying() and (Wings or wingTexture))
    animations.pony.flying:setPlaying(pose == "FALL_FLYING" and vel.y > 0 and vel:length() < 1.25)
    animations.pony.flyingdown:setPlaying(pose == "FALL_FLYING" and (vel.y < 0 or vel:length() > 1.25))
    animations.pony.spinattack:setPlaying(pose == "SPIN_ATTACK")
    animations.pony.sleeping:setPlaying(pose == "SLEEPING")
    animations.pony.Dying:setPlaying(not player:isAlive())

    if Magic then
        if bowingL or bowingR or crossL or crossR or loadingL or loadingR then
            models.pony.LeftArm.LeftArm:setVisible(true)
            models.pony.RightArm.RightArm:setVisible(true)
        else
            if leftItem.id ~= "minecraft:air" or leftSwing then
                models.pony.LeftArm.LeftArm:setVisible(true)
            else
                models.pony.LeftArm.LeftArm:setVisible(false)
            end
            if rightItem.id ~= "minecraft:air" or rightSwing then
                models.pony.RightArm.RightArm:setVisible(true)
            else
                models.pony.RightArm.RightArm:setVisible(false)
            end
        end
        if models.pony.Root.body.neck.head.horn:getVisible() and (models.pony.RightArm.RightArm:getVisible() or models.pony.LeftArm.LeftArm:getVisible()) then
            models.pony.Root.body.neck.head.horn_glow:setVisible(true)
        else
            models.pony.Root.body.neck.head.horn_glow:setVisible(false)
        end
    else
        models.pony.RightArm.RightArm:setVisible(false)
        models.pony.LeftArm.LeftArm:setVisible(false)
    end

    models.pony.Root.right_front_leg.RIGHT_ITEM_PIVOT:setVisible(not Magic)
    models.pony.Root.left_front_leg.LEFT_ITEM_PIVOT:setVisible(not Magic)

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
events.RENDER:register(function (t,ctx)
    local r = vec(math.lerp(lrot.x, rot.x, t), math.lerp(lrot.y, rot.y, t), math.lerp(lrot.z, rot.z, t))
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
        if bowingL or bowingR then
            models.pony.Root.left_front_leg:offsetRot(r.x * 0.9, r.y * 0.5, 0)
            models.pony.Root.right_front_leg:offsetRot(r.x * 0.9, r.y * 0.5, 0)
        elseif crossR or crossL then
            models.pony.Root.left_front_leg:offsetRot(r.x * 0.9, r.y, 0)
            models.pony.Root.right_front_leg:offsetRot(r.x * 0.9, r.y, 0)
        end
        if spyglassR or hornR or eatingR or drinkingR then
            models.pony.Root.right_front_leg:offsetRot(r.x * 0.75, r.y * 0.9, 0)
        elseif spyglassL or hornL or eatingL or drinkingL then
            models.pony.Root.left_front_leg:offsetRot(r.x * 0.75, r.y * 0.9, 0)
        end
    end

    models.pony.Root.body.neck.head:setRot(r.x * 0.9, r.y, 0)
    models.pony.Root:setRot(r.x * 0.1, 0, 0)
    models.pony.Root.body.Tail:setRot(vanilla_model.FAKE_CAPE:getOriginRot() + vec(15,0,0))
    models.pony.RightArm.r_front_leg:setVisible(ctx == "FIRST_PERSON" and not Magic)
    models.pony.LeftArm.l_front_leg:setVisible(ctx == "FIRST_PERSON" and not Magic)
end)

require("GSAnimBlend") -- Instruction count goes brrrrr

--for key,value in pairs(animations:getAnimations()) do
--    value:blendTime(1)
--end

animations.pony.idle:blendTime(3)
--animations.pony.crouch:blendTime(0)
--animations.pony.sit:blendTime(0)

animations.pony.walk:blendTime(3)
animations.pony.sprint:blendTime(5)

animations.pony.jumpup:blendTime(3)
animations.pony.jumpdown:blendTime(3)
animations.pony.fall:blendTime(5)
--animations.pony.land:blendTime(0)

animations.pony.climb:blendTime(6)
--animations.pony.crawl:blendTime(0)
--animations.pony.swim:blendTime(0)
animations.pony.flying:blendTime(3)
animations.pony.flyingdown:blendTime(3)