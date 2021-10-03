
local function move(key)
    local f = player.facing
    if f == "north" then
        if key == Controls.up then
            f = "north"
        elseif key == Controls.right then
            f = "east"
        elseif key == Controls.down then
            f = "south"
        elseif key == Controls.left then
            f = "west"
        end
    elseif f == "east" then
        if key == Controls.up then
            f = "east"
        elseif key == Controls.right then
            f = "south"
        elseif key == Controls.down then
            f = "west"
        elseif key == Controls.left then
            f = "north"
        end
    elseif f == "south" then
        if key == Controls.up then
            f = "south"
        elseif key == Controls.right then
            f = "west"
        elseif key == Controls.down then
            f = "north"
        elseif key == Controls.left then
            f = "east"
        end
    elseif f == "west" then
        if key == Controls.up then
            f = "west"
        elseif key == Controls.right then
            f = "north"
        elseif key == Controls.down then
            f = "east"
        elseif key == Controls.left then
            f = "south"
        end
    end

    return f
end

return move