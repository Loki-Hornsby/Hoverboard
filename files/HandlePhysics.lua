---->> Utilities
dofile("mods/Hoverboard/files/utilities.lua")
dofile_once("data/scripts/lib/utilities.lua")

---->> Components
local PhysicsComponent = EntityGetFirstComponentIncludingDisabled(getBoardEntity(), "PhysicsBodyComponent")

---->> Positions
local BX, BY, BRot = EntityGetTransform(getBoardEntity())
local PlyX, PlyY, PlyRot = EntityGetTransform(getPlayerEntity())

---->> Velocity
local VelX, VelY = PhysicsGetComponentVelocity(getBoardEntity(), PhysicsComponent)
local AngVel = PhysicsGetComponentAngularVelocity(getBoardEntity(), PhysicsComponent)

---->> Raytrace calcs
local RotVecCalcX = -math.sin(BRot)
local RotVecCalcY = math.cos(BRot)

---->> Raytraces
local Grounded, GroundX, GroundY = RaytraceSurfacesAndLiquiform(
	BX + RotVecCalcX*10, 
	BY + RotVecCalcY*10, 
	BX + RotVecCalcX*10, 
	BY + RotVecCalcY*10)


---->> Ground distance
local GroundDist = get_distance(BX, BY, GroundX, GroundY)

---->> Hovering
local FloatHeight = -10

if Grounded then
	if GroundDist < 4 then
		PhysicsApplyForce(getBoardEntity(), 0, 0 - VelY)
	end

	PhysicsApplyForce(getBoardEntity(), RotVecCalcX*20 + -3, -RotVecCalcY*20)
else
	PhysicsApplyForce(getBoardEntity(), 0, -FloatHeight*2 + -VelY*10)
end


---->> Rotate to match terrain

function approx_rolling_average(avg, new_sample, n)
	avg = avg - avg / n;
	avg = avg + new_sample / n;
	return avg
end

function get_direction( x1, y1, x2, y2 )
	return math.atan2( ( y2 - y1 ), ( x2 - x1 ) )
end

local found_normal,normal_x,normal_y,approximate_distance_from_surface = GetSurfaceNormal(GroundX, GroundY, 10, 16)

local old_average = GetValueNumber("average_rotation", 0)

local dir = get_direction(0, 0, normal_x, normal_y)

local degree_shift = math.rad(-90) + dir 
-- 90 degree rotation to properly orient the entity

local new_average = approx_rolling_average(old_average, degree_shift, 1) 
-- if the number is higher than 5 the turning speed would be smoother and slower, if less it would be more instantaneous

SetValueNumber("average_rotation", new_average)

if BRot < math.deg(90) and BRot > math.deg(-90) then
	PhysicsApplyTorque(getBoardEntity(), new_average - BRot)
else
	PhysicsApplyTorque(getBoardEntity(), 0 - BRot)
end

---->> Tesing

if TEST == nil then
	A = EntityLoad("mods/Hoverboard/files/ParticleTest.xml", 0, 0)

	TEST = 1
end

EntitySetTransform(A, GroundX, GroundY)


