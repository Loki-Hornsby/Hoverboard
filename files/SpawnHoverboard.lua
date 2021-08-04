dofile("data/scripts/director_helpers.lua")
dofile("data/scripts/biomes/mountain/mountain.lua")

dofile("data/scripts/lib/utilities.lua")
dofile("mods/Ride Minecart/files/utilities.lua")

--------------------- This forecefully sets the set item as a Portal trigger or Portal!

g_cartlike = {
	total_prob = 0,
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,
		offset_y 	= 0,
		offset_x    = 0,
		entity 	= "mods/Hoverboard/files/Hoverboard.xml"
	},
}

--------------------- This sets portal position

function spawn_crate(x, y)
	spawn(g_cartlike,x,y) 
end
