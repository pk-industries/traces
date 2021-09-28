
local function move(key, currentD)
    local d = currentD
    if d == "north" then
        if key == up_key then
            d = "north"
        elseif key == right_key then
            d = "east"
        elseif key == down_key then
            d = "south"
        elseif key == left_key then
            d = "west"
        end
    elseif d == "east" then
        if key == up_key then
            d = "east"
        elseif key == right_key then
            d = "south"
        elseif key == down_key then
            d = "west"
        elseif key == left_key then
            d = "north"
        end
    elseif d == "south" then
        if key == up_key then
            d = "south"
        elseif key == right_key then
            d = "west"
        elseif key == down_key then
            d = "north"
        elseif key == left_key then
            d = "east"
        end
    elseif d == "west" then
        if key == up_key then
            d = "west"
        elseif key == right_key then
            d = "north"
        elseif key == down_key then
            d = "east"
        elseif key == left_key then
            d = "south"
        end
    end

    return d
end

return move