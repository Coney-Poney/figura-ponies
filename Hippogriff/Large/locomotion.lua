local vel
local pose = ""
local vehicle = nil
local rot = vec(0,0,0)
local lrot = vec(0,0,0)
local landVel = 0
local wingTexture = false

local modelsponyRoot = models.pony.Root
local animationspony = animations.pony

-----------for switch case-----------
local action_count = 9
local using_list = {
    [0] = notuse, animationspony.drinkingR, animationspony.eatingR, animationspony.blockingR, animationspony.bowR, animationspony.spearR, animationspony.spyglassR, animationspony.hornR, animationspony.loadingR,
    notuse, animationspony.drinkingL, animationspony.eatingL, animationspony.blockingL, animationspony.bowL, animationspony.spearL, animationspony.spyglassL, animationspony.hornL, animationspony.loadingL
}  --list of all actions when no magic and correspond to action using
local crossR, crossL

local using_index = {
    DRINK = 1, EAT = 2, BLOCK = 3, BOW = 4, SPEAR = 5, SPYGLASS = 6, TOOT_HORN = 7, CROSSBOW = 8
} --table for lookup indices
local rvalue, lvalue = 0, action_count --value to detect what to turn on/off for left/right hoof

local emote_list = {
    [0] = notuse, animationspony.Yee_Haw, animationspony.sit, animationspony.dance, animationspony.spin, animationspony.loaf, animationspony.gStyle
} --list of emote 
local distance_travel_switch, alive_switch, fly_switch, movingstate_switch, landing_switch, climb_switch, VisuallySwimming_switch, jump_switch --detect changes 
local LeftArm_vis, RightArm_vis, horn_glow_vis = false, false, false
local rightSwing, leftSwing = false, false
local emote_switch = emote
-----------for switch case-----------

local GSBlend = require("GSAnimBlend") -- Instruction count goes brrrrr
--GSBlend.safe = false -- turning this off crashes game when reload :D 

-- Animations
events.TICK:register(function()
    lrot = rot
    rot = vanilla_model.HEAD:getOriginRot()
    vel = player:getVelocity()
    local hand = player:isLeftHanded()
    local rightHand = hand and "OFF_HAND" or "MAIN_HAND"
    local leftHand = not hand and "OFF_HAND" or "MAIN_HAND"
    local rightItem = player:getHeldItem(hand)
    local leftItem = player:getHeldItem(not hand)
    local isClimb = player:isClimbing()
    local isOnGround = player:isOnGround()
    local isVisuallySwimming = player:isVisuallySwimming()
    local isFlying = player:isFlying()
    local isAlive = player:isAlive()
    local isInWater = player:isInWater()
    local isUnderwater = player:isUnderwater()
    local radRot = math.rad(-player:getBodyYaw())
    local localVel = vec(
      (math.cos(radRot) * vel.x) + (math.sin(radRot) * vel.z),
      (math.sin(radRot) * vel.x) + (math.cos(radRot) * vel.z)
    )
    local distance_travel = localVel:length()
    local movingstate = isClimb or isFlying or vehicle or (pose ~= "STANDING" and pose ~= "CROUCHING")
    local using = player:isUsingItem()
    local active = player:getActiveHand()
    local usingR, usingL
    if using then
        usingR = active == rightHand and rightItem:getUseAction()
        usingL = active == leftHand and leftItem:getUseAction()
    end

    if rightSwing ~= (player:getSwingArm() == rightHand and pose ~= "SLEEPING") or rightSwing then
        rightSwing = player:getSwingArm() == rightHand and pose ~= "SLEEPING"
        if not Magic then
            animationspony.swingR:setPlaying(rightSwing)
        end
    end
    if leftSwing ~= (player:getSwingArm() == leftHand and pose ~= "SLEEPING") or leftSwing then
        leftSwing = player:getSwingArm() == leftHand and pose ~= "SLEEPING"
        if not Magic then
            animationspony.swingL:setPlaying(leftSwing)
        end
    end

    if not Magic then
        if crossR ~= (rightItem.tag and rightItem.tag["Charged"] == 1) then
            crossR = rightItem.tag and rightItem.tag["Charged"] == 1
            animationspony.crossR:setPlaying(crossR)
        end
        if crossL ~= (leftItem.tag and leftItem.tag["Charged"] == 1) then
            crossL = leftItem.tag and leftItem.tag["Charged"] == 1
            animationspony.crossL:setPlaying(crossL)
        end

        if using then
            if rvalue ~= (using_index[usingR] or 0) then
                if rvalue ~= 0 then
                    using_list[rvalue]:stop()
                end
                rvalue = (using_index[usingR] or 0)
                if rvalue ~= 0 then
                    using_list[rvalue]:play()
                end
            end
            if lvalue ~= (using_index[usingL] or 0) + action_count then
                if lvalue ~= action_count then
                    using_list[lvalue]:stop()
                end
                lvalue = (using_index[usingL] or 0) + action_count
                if lvalue ~= action_count then
                    using_list[lvalue]:play()
                end
            end
        else
            if rvalue ~= 0 then
                using_list[rvalue]:stop()
            end
            if lvalue ~= action_count then
                using_list[lvalue]:stop()
            end
            rvalue = 0
            lvalue = action_count
        end

        if rightItem.id ~= "minecraft:air" and not (crossL or crossR or rvalue == 4 or lvalue == 13 or pose == "CROUCHING") then --bowingR/L 
            modelsponyRoot.right_front_leg:offsetRot(15,0,0)
        else
            modelsponyRoot.right_front_leg:offsetRot(0,0,0)
        end
        if leftItem.id ~= "minecraft:air" and not (crossL or crossR or rvalue == 4 or lvalue == 13 or pose == "CROUCHING") then --bowingR/L 
            modelsponyRoot.left_front_leg:offsetRot(15,0,0)
        else
            modelsponyRoot.left_front_leg:offsetRot(0,0,0)
        end
    end

    if pose ~= player:getPose() then
        pose = player:getPose()
        if pose ~= "FALL_FLYING" then
            animationspony.flying:stop()
            animationspony.flyingdown:stop()
        end

        if pose == "CROUCHING" then
            animationspony.crouch:play()
        elseif pose == "SPIN_ATTACK" then
            animationspony.spinattack:play()
        elseif pose == "SLEEPING" then
            animationspony.sleeping:play()
        end

        if pose ~= "CROUCHING" then
            animationspony.crouch:stop()
        elseif pose ~= "SPIN_ATTACK" then
            animationspony.spinattack:stop()
        elseif pose ~= "SLEEPING" then
            animationspony.sleeping:stop()
        end
    end
    
    if not isOnGround and not isClimb and not isFlying then -- Jump Fall speed
        if vel.y < 0 and vel.y > -0.375 and pose ~= "FALL_FLYING" then --0 for switching for jumping up to down
            if jump_switch ~= 0 and jump_switch == 2 then -- ONLY plays if jumpup is playing
                jump_switch = 0
                animationspony.jumpup:stop()
                animationspony.jumpdown:play()
            end
        elseif vel.y < -0.4 and not isInWater then --1 for falling animation 
            landVel = math.clamp(math.map(vel.y, 0, -1, 0, 1.25),0,2)
            animationspony.fall:speed(vel.y*-2.5)
            if jump_switch ~= 1 then
                jump_switch = 1
                animationspony.fall:play()
            end
        elseif vel.y > 0 and pose ~= "FALL_FLYING" then --for jump up 
            if jump_switch ~= 2 then
                jump_switch = 2
                animationspony.jumpup:play()
                animationspony.jumpdown:stop()
            end
        end
    end

    if landing_switch ~= (isOnGround or isUnderwater) then -- Jump Fall switch
        landing_switch = isOnGround or isUnderwater
        if landing_switch then
            if jump_switch == 2 then
                animationspony.jumpup:stop()
            end
            if jump_switch == 0 then
                animationspony.jumpdown:stop()
            end
            if jump_switch == 1 then
                animationspony.jumpdown:stop()
                animationspony.fall:stop()
                animationspony.land:blend(landVel)
                animationspony.land:play()
            end
        else
            emote = 0
        end
    end

    if not movingstate then -- Locomotion  --not climb, not fly, not vehicle, stand or crouch
        if movingstate_switch ~= movingstate then      --switch
            if animationspony.climb:getPlayState() == "PLAYING" then
                animationspony.climb:stop()
            end
            if animationspony.swim:getPlayState() == "PLAYING" then
                animationspony.swim:stop()
            end
            if animationspony.crawl:getPlayState() == "PLAYING" then
                animationspony.crawl:stop()
            end
            if animationspony.flying:getPlayState() == "PLAYING" then
                animationspony.flying:stop()
            end
            if animationspony.flyingdown:getPlayState() == "PLAYING" then
                animationspony.flyingdown:stop()
            end
            if animationspony.sleeping:getPlayState() == "PLAYING" then
                animationspony.sleeping:stop()
            end
            if animationspony.spinattack:getPlayState() == "PLAYING" then
                animationspony.spinattack:stop()
            end
            movingstate_switch = movingstate
        end

        if distance_travel > 0.03 then -- Walking, Sprinting, and Idle
            local block = world.getBlockState(player:getPos().x,player:getPos().y-0.1,player:getPos().z):toStateString()
            local sprint_check = player:isSprinting() and pose ~= "CROUCHING" and (rvalue == 0 or lvalue == 9) and not (block == "minecraft:soul_sand{}" or block == "minecraft:honey_block{}" or block == "minecraft:slime_block{}") --blockingR/L 
            if sprint_check then
                animationspony.sprint:speed(localVel.y * 17.5)
            else
                animationspony.walk:speed(localVel.y * 17.5)
            end
            if distance_travel_switch == 0 then
                animationspony.idle:stop()
                if sprint_check then
                    animationspony.sprint:play()
                    distance_travel_switch = 2
                else
                    animationspony.walk:play()
                    distance_travel_switch = 1
                end
            elseif distance_travel_switch == 1 and sprint_check then
                animationspony.sprint:play()
                animationspony.walk:stop()
                distance_travel_switch = 2
            elseif distance_travel_switch == 2 and not sprint_check then
                animationspony.walk:play()
                animationspony.sprint:stop()
                distance_travel_switch = 1
            end
            emote = 0
        else
            if distance_travel_switch == 1 then
                animationspony.walk:stop()
                animationspony.idle:play()
            elseif distance_travel_switch == 2 then
                animationspony.sprint:stop()
                animationspony.idle:play()
            end
            distance_travel_switch = 0
        end
    else
        if movingstate_switch ~= movingstate then
            if animationspony.jumpup:getPlayState() == "PLAYING" then
                animationspony.jumpup:stop()
            end
            if animationspony.jumpdown:getPlayState() == "PLAYING" then
                animationspony.jumpdown:stop()
            end
            if animationspony.fall:getPlayState() == "PLAYING" then
                animationspony.fall:stop()
            end
            if animationspony.sprint:getPlayState() == "PLAYING" then
                animationspony.sprint:stop()
            end
            if animationspony.walk:getPlayState() == "PLAYING" then
                animationspony.walk:stop()
            end
            movingstate_switch = movingstate
            distance_travel_switch = 0
        end

        if isClimb and not isOnGround then -- Climb speed
            animationspony.climb:speed(vel.y * 15)
        end

        if isVisuallySwimming then -- Swim/Crawl speed
            if jump_switch == 1 then
                animationspony.land:blend(landVel)
                jump_switch = -1
            end
            if isInWater then
                animationspony.swim:speed(vel:length() * 7)
            else
                animationspony.crawl:speed(localVel.y * 15)
            end
        end

        if pose == "FALL_FLYING" then -- Elytra
            if vel.y > 0  and vel:length() < 1.25 then
                animationspony.flyingdown:stop()
                animationspony.flying:play()
            elseif vel.y < 0 or vel:length() > 1.25 then
                animationspony.flying:stop()
                animationspony.flyingdown:play()
            end
        end
    end

    if climb_switch ~= (isClimb and (not isOnGround)) then -- Climb switch
        climb_switch = (isClimb and (not isOnGround))
        animationspony.climb:setPlaying(climb_switch)
    end
    if VisuallySwimming_switch ~= isVisuallySwimming then -- Swim/Crawl
        VisuallySwimming_switch = isVisuallySwimming
        if isInWater then
            animationspony.swim:setPlaying(VisuallySwimming_switch)
        else
            animationspony.crawl:setPlaying(VisuallySwimming_switch)
        end
    end
    if fly_switch ~= (isFlying and (Wings or wingTexture)) then -- fly switch
        fly_switch = isFlying and (Wings or wingTexture)
        animationspony.hover:setPlaying(isFlying and (Wings or wingTexture))
    end
    if alive_switch ~= isAlive then
        alive_switch = isAlive
        animationspony.Dying:setPlaying(not alive_switch)
    end
    if vehicle ~= player:getVehicle() then
        vehicle = player:getVehicle()
        if vehicle then
            emote_list[2]:play() -- sit or not sit
        else
            emote_list[2]:stop()
        end
    end
    if emote ~= emote_switch then
        if emote_switch ~= 0 then
            emote_list[emote_switch]:stop()
        end
        emote_switch = emote
        if emote ~= 0 then
            emote_list[emote]:play()
        end
    end
    
    if Magic then -- Magic Aura
        if rvalue == 4 or rvalue == 8 or lvalue == 13 or lvalue == 17 or crossL or crossR then --bowingR, loadingR, bowingL, loadingL
            if not LeftArm_vis then
                LeftArm_vis = true
            end
            if not RightArm_vis then
                RightArm_vis = true
            end
        else
            LeftArm_vis = leftItem.id ~= "minecraft:air" or leftSwing
            RightArm_vis = rightItem.id ~= "minecraft:air" or rightSwing
        end
        horn_glow_vis = Horn and (LeftArm_vis or RightArm_vis)
        models.pony.LeftArm.LeftArm:setVisible(LeftArm_vis)
        models.pony.RightArm.RightArm:setVisible(RightArm_vis)
        modelsponyRoot.body.neck.head.horn_glow:setVisible(horn_glow_vis)
    end

    if not Wings then
        if player:getItem(5).id == "minecraft:elytra" then
            wingTexture = true
            modelsponyRoot.body.left_wing:setVisible(true)
            modelsponyRoot.body.right_wing:setVisible(true)
        else
            modelsponyRoot.body.left_wing:setVisible(false)
            modelsponyRoot.body.right_wing:setVisible(false)
            if wingTexture then
                wingTexture = false
            end
        end
    end
end)

-- Arm and Head movement
events.RENDER:register(function (t,ctx)
    local r = vec(math.lerp(lrot.x, rot.x, t), math.lerp(lrot.y, rot.y, t), math.lerp(lrot.z, rot.z, t))
    if pose == "SWIMMING" or pose == "FALL_FLYING" or pose == "SPIN_ATTACK" then
        modelsponyRoot:offsetRot(90, 0, 0)
        modelsponyRoot:setPos(0,13.75,-17)
    elseif pose == "SLEEPING" then
        modelsponyRoot:offsetRot(-90, 0, 180)
        modelsponyRoot:setPos(0,13.75,1.25)
    else
        modelsponyRoot:offsetRot(0,0,0)
        if vehicle then
            modelsponyRoot:setPos(0,9,-7)
        elseif pose == 'CROUCHING' then
            modelsponyRoot:setPos(0,1,0)
        else
            modelsponyRoot:setPos(0,0,0)
        end
    end
    if not Magic then
        if rvalue == 4 or lvalue == 13 then --bowingR/L
            modelsponyRoot.left_front_leg:offsetRot(r.x * 0.9, r.y * 0.5, 0)
            modelsponyRoot.right_front_leg:offsetRot(r.x * 0.9, r.y * 0.5, 0)
        elseif crossR or crossL then
            modelsponyRoot.left_front_leg:offsetRot(r.x * 0.9, r.y, 0)
            modelsponyRoot.right_front_leg:offsetRot(r.x * 0.9, r.y, 0)
        end
        if rvalue == 6 or rvalue == 7 or rvalue == 2 or rvalue == 1 then --spyglassR, hornR, eatingR, drinkingR
            modelsponyRoot.right_front_leg:offsetRot(r.x * 0.75, r.y * 0.9, 0)
        elseif lvalue == 15 or lvalue == 16 or lvalue == 11 or lvalue == 10 then --spyglassL, hornL, eatingL ,drinkingL
            modelsponyRoot.left_front_leg:offsetRot(r.x * 0.75, r.y * 0.9, 0)
        end
    end

    modelsponyRoot.body.neck.head:setRot(r.x * 0.85, r.y, 0)
    modelsponyRoot.body.neck:setRot(r.x * 0.15, 0, 0)
    modelsponyRoot.body.Tail:setRot(vanilla_model.FAKE_CAPE:getOriginRot() + vec(15,0,0))
    models.pony.RightArm.r_front_leg:setVisible(ctx == "FIRST_PERSON" and not Magic)
    models.pony.LeftArm.l_front_leg:setVisible(ctx == "FIRST_PERSON" and not Magic)
end)

--for key,value in pairs(animations:getAnimations()) do
--    value:blendTime(1)
--end

animationspony.idle:blendTime(3)
--animationspony.crouch:blendTime(0)
--animationspony.sit:blendTime(0)

animationspony.walk:blendTime(3)
animationspony.sprint:blendTime(5)

animationspony.jumpup:blendTime(3)
animationspony.jumpdown:blendTime(3)
animationspony.fall:blendTime(5)
--animationspony.land:blendTime(0)

animationspony.climb:blendTime(8)
--animationspony.crawl:blendTime(0)
--animationspony.swim:blendTime(0)
--animationspony.flying:blendTime(3)
animationspony.flyingdown:blendTime(3)
