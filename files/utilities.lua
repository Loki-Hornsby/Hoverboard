------------------------- Returns whether an entity is damaged -------------------------
function Damaged(PhysicsObj, original_pixel_count)
    -- Return if damaged
    local DesiredPercentage = 1

    local pixel_count = ComponentGetValue2(PhysicsObj, "mPixelCount")
    local CurrentDestruction = ((original_pixel_count - pixel_count) / original_pixel_count) * 100

    if CurrentDestruction < DesiredPercentage then
        return false
    else
       return true
    end
end

------------------------- Returns Player Entity -------------------------
function getPlayerEntity()
    local players = EntityGetWithTag("player_unit")

    if #players == 0 then 
       return nil
    end

    return players[1]
end

------------------------- Returns Board Entity -------------------------
function getBoardEntity()
    local Board = EntityGetWithName("Hoverboard")

    return Board
end