dofile("data/scripts/lib/utilities.lua") -- Base Utilities
dofile("mods/Hoverboard/files/utilities.lua") -- My Utilities

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    if interactable_name == "hoverboard_interact" then
        local Riding = "Hoverboard_riding"
        
        if GlobalsGetValue(Riding, "0") == "1" then
            GlobalsSetValue(Riding, "0")
        else
            GamePrint("Riding")
            GlobalsSetValue(Riding, "1")
        end
    end
end