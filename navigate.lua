function Move(key)
    if DIRECTION == "north" then
        if key == UP_KEY then
            DIRECTION = "north"
        elseif key == RIGHT_KEY then
            DIRECTION = "east"
        elseif key == DOWN_KEY then
            DIRECTION = "south"
        elseif key == LEFT_KEY then
            DIRECTION = "west"
        end
    elseif DIRECTION == "east" then
        if key == UP_KEY then
            DIRECTION = "east"
        elseif key == RIGHT_KEY then
            DIRECTION = "south"
        elseif key == DOWN_KEY then
            DIRECTION = "west"
        elseif key == LEFT_KEY then
            DIRECTION = "north"
        end
    elseif DIRECTION == "south" then
        if key == UP_KEY then
            DIRECTION = "south"
        elseif key == RIGHT_KEY then
            DIRECTION = "west"
        elseif key == DOWN_KEY then
            DIRECTION = "north"
        elseif key == LEFT_KEY then
            DIRECTION = "east"
        end
    elseif DIRECTION == "west" then
        if key == UP_KEY then
            DIRECTION = "west"
        elseif key == RIGHT_KEY then
            DIRECTION = "north"
        elseif key == DOWN_KEY then
            DIRECTION = "east"
        elseif key == LEFT_KEY then
            DIRECTION = "south"
        end
    end

    return DIRECTION
end

return Move