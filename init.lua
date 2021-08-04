-- dofile
-- dofile_once("")
--ModLuaFileAppend("", "")
--ModMaterialsFileAdd("")

---->> Utilities
dofile_once("mods/Hoverboard/files/utilities.lua")

---->> Change minecart for board
ModLuaFileAppend("data/scripts/biomes/mountain/mountain_hall.lua", "mods/Hoverboard/files/SpawnHoverboard.lua")

---->> Keys
local Riding = "Hoverboard_riding"
local State = "Hoverboard_state"
 
---->> Initialization
function OnPlayerSpawned(player)
    GlobalsSetValue(Riding, "0")
    GlobalsSetValue(State, "Off")
end
