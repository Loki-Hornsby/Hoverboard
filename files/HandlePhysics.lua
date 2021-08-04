---->> Utilities
dofile("mods/Hoverboard/files/utilities.lua")
dofile_once("data/scripts/lib/utilities.lua")

---->> General
local Board = getBoardEntity()
local BX, BY, BRot = EntityGetTransform(Board)

local Ply = getPlayerEntity()
local PlyX, PlyY, PlyRot = EntityGetTransform(Ply)

---->> Global States
local RidingKey = "Hoverboard_riding"
local Riding = GlobalsGetValue(RidingKey, "0")

local StateKey = "Hoverboard_state"
local State = GlobalsGetValue(StateKey, "0")

---->> Components
local PhysicsComponent = EntityGetFirstComponentIncludingDisabled(Board, "PhysicsBodyComponent")

---->> Velocity
local VelX, VelY = PhysicsGetComponentVelocity(Board, PhysicsComponent)
local AngVel = PhysicsGetComponentAngularVelocity(Board, PhysicsComponent)

---->> Raytrace calcs
local RotVecCalcX = -math.sin(BRot)
local RotVecCalcY = math.cos(BRot)

---->> Raytraces
local Grounded, GroundX, GroundY = RaytraceSurfacesAndLiquiform(
	BX + RotVecCalcX*10, 
	BY + RotVecCalcY*10, 
	BX + RotVecCalcX*10, 
	BY + RotVecCalcY*10)

---->> Hovering
local GroundDist = get_distance(BX, BY, GroundX, GroundY)
local FloatHeight = -10

if State == "On" then
	if Grounded then
		if GroundDist < 4 then
			PhysicsApplyForce(Board, 0, 0 - VelY)
		end

		PhysicsApplyForce(Board, RotVecCalcX*20, -RotVecCalcY*20)
	else
		PhysicsApplyForce(Board, 0, -FloatHeight*2 + -VelY*10)
	end
else
	PhysicsApplyForce(Board, 0, -1)
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

if State == "On" then
	if BRot < math.deg(90) and BRot > math.deg(-90) then
		--PhysicsApplyTorque(Board, new_average - BRot)
	else
		--PhysicsApplyTorque(Board, 0 - BRot)
	end
end

---->> Testing

-- Tracking for GroundX and GroundY
if TEST == nil then
	A = EntityLoad("mods/Hoverboard/files/ParticleTest.xml", 0, 0)

	TEST = 1
end

EntitySetTransform(A, GroundX, GroundY)


