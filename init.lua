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
 
---->> On player init
function OnPlayerSpawned(player)
    GlobalsSetValue(Riding, "0")
end
