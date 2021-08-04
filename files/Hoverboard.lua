---->> Do files
dofile("mods/Hoverboard/files/HandlePhysics.lua")
dofile("mods/Hoverboard/files/utilities.lua")
dofile("mods/Hoverboard/files/GUI.lua")

---->> General
local Board = getBoardEntity()
local BX, BY, BRot = EntityGetTransform(Board)

local Ply = getPlayerEntity()
local PlyX, PlyY, PlyRot = EntityGetTransform(Ply)

local PhysicsComponent = EntityGetFirstComponentIncludingDisabled(Board, "PhysicsBodyComponent")

---->> Turn On
local StateKey = "Hoverboard_state"
local State = GlobalsGetValue(StateKey, "0")

local plydist = get_distance(BX, BY, PlyX, PlyY)

if plydist < 6 then
	GlobalsSetValue(StateKey, "On")
else 
	GlobalsSetValue(StateKey, "Off")
end

---->> Hoverboard Trails
local VelX, VelY = PhysicsGetComponentVelocity(Board, PhysicsComponent)

local BackEmit = EntityGetComponentIncludingDisabled(Board, "ParticleEmitterComponent")[1]
local FrontEmit = EntityGetComponentIncludingDisabled(Board, "ParticleEmitterComponent")[2]

if State == "On" then
    if not ComponentGetIsEnabled(FrontEmit) then
        EntitySetComponentIsEnabled(Board, BackEmit, true)
        EntitySetComponentIsEnabled(Board, FrontEmit, true)
    end

    ComponentSetValue2(BackEmit, "x_vel_max", 7 + -VelX*10)
    ComponentSetValue2(FrontEmit, "x_vel_max", 7 + -VelX*10)
else 
    if ComponentGetIsEnabled(FrontEmit) then
        EntitySetComponentIsEnabled(Board, BackEmit, false)
        EntitySetComponentIsEnabled(Board, FrontEmit, false)
    end
end

---->> Riding State

local RidingKey = "Hoverboard_riding"
local Riding = GlobalsGetValue(RidingKey, "0")

local CollisionComponent = EntityGetFirstComponentIncludingDisabled(Ply, "PlayerCollisionComponent")

if Riding == "1" and State == "On" then
    if ComponentGetIsEnabled(CollisionComponent) then
        EntitySetComponentIsEnabled(Ply, CollisionComponent, false)
    end

    EntitySetTransform(Ply, BX, BY-5, BRot)
else
    if not ComponentGetIsEnabled(CollisionComponent) then
        EntitySetTransform(Ply, BX, BY-10, 0)

        EntitySetComponentIsEnabled(Ply, CollisionComponent, true)
    end
end


-- remember to sort out front and back emitters

-- make the emitters so they seem to "rotate to counteract the velocity"

-- make sure your ready for game jam too and when its over DO NOT play noita as much
-- hi past me the game jam was a chaotic fuck mess but ive learnt alot so thats a pro
