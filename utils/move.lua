local function move(key, direction)
    local nextDirection = direction
    if direction == "n" then
        if key == Controls.up then
            nextDirection = "n"
        elseif key == Controls.right then
            nextDirection = "e"
        elseif key == Controls.down then
            nextDirection = "s"
        elseif key == Controls.left then
            nextDirection = "w"
        end
    elseif direction == 'e' then
        if key == Controls.up then
            nextDirection = 'e'
        elseif key == Controls.right then
            nextDirection = 's'
        elseif key == Controls.down then
            nextDirection = 'w'
        elseif key == Controls.left then
            nextDirection = 'n'
        end

    elseif direction == 'w' then
        if key == Controls.up then
            nextDirection = 'w'
        elseif key == Controls.right then
            nextDirection = 'n'
        elseif key == Controls.down then
            nextDirection = 'e'
        elseif key == Controls.left then
            nextDirection = 's'
        end
        elseif direction == "s" then
        if key == Controls.up then
            nextDirection = "s"
        elseif key == Controls.right then
            nextDirection = "w"
        elseif key == Controls.down then
            nextDirection = "n"
        elseif key == Controls.left then
            nextDirection = "e"
        end
    end

    return nextDirection
end

return move

--[[   ]]

--[[     ]]
