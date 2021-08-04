---->> Do files
dofile("mods/Hoverboard/files/HandlePhysics.lua")
dofile("mods/Hoverboard/files/utilities.lua")
dofile("mods/Hoverboard/files/GUI.lua")

---->> Vars
local PhysicsComponent = EntityGetFirstComponentIncludingDisabled(getBoardEntity(), "PhysicsBodyComponent")

local VelX, VelY = PhysicsGetComponentVelocity(getBoardEntity(), PhysicsComponent)

local BX, BY, BRot = EntityGetTransform(getBoardEntity())

---->> Change hoverboard trail angles
local BackEmit = EntityGetComponent(getBoardEntity(), "ParticleEmitterComponent")[1]
local FrontEmit = EntityGetComponent(getBoardEntity(), "ParticleEmitterComponent")[2]

ComponentSetValue2(BackEmit, "x_vel_max", 7 + -VelX*10)
ComponentSetValue2(FrontEmit, "x_vel_max", 7 + -VelX*10)
-- remember to sort out front and back emitters

-- make the emitters so they seem to "rotate to counteract the velocity"

-- make sure your ready for game jam too and when its over DO NOT play noita as much

