
local function move(key)
    local f = player.facing
    if f == "north" then
        if key == up_key then
            f = "north"
        elseif key == right_key then
            f = "east"
        elseif key == down_key then
            f = "south"
        elseif key == left_key then
            f = "west"
        end
    elseif f == "east" then
        if key == up_key then
            f = "east"
        elseif key == right_key then
            f = "south"
        elseif key == down_key then
            f = "west"
        elseif key == left_key then
            f = "north"
        end
    elseif f == "south" then
        if key == up_key then
            f = "south"
        elseif key == right_key then
            f = "west"
        elseif key == down_key then
            f = "north"
        elseif key == left_key then
            f = "east"
        end
    elseif f == "west" then
        if key == up_key then
            f = "west"
        elseif key == right_key then
            f = "north"
        elseif key == down_key then
            f = "east"
        elseif key == left_key then
            f = "south"
        end
    end

    return f
end

return move