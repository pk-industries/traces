---@param key love.KeyConstant
---@param direction string
---@param x number
---@param y number
---@param width number
---@param height number
local function move(key, direction, x, y, width, height)
    if direction == 'n' then
        if key == Controls.up and y + 1 <= height then
            y = y + 1
        elseif key == Controls.right then
            direction = 'e'
        elseif key == Controls.down and y-1 >=1 then
            y = y - 1
        elseif key == Controls.left then
            direction = 'w'
        end
    elseif direction == 'e' then
        if key == Controls.up and x + 1 <= width then
            x = x + 1
        elseif key == Controls.right then
            direction = 's'
        elseif key == Controls.down and x-1>=1 then
            x = x - 1
        elseif key == Controls.left then
            direction = 'n'
        end
    elseif direction == 's' then
        if key == Controls.up and y - 1 >= 1 then
            y = y - 1
        elseif key == Controls.right then
            direction = 'w'
        elseif key == Controls.down and y +1 <= height then
            y = y + 1
        elseif key == Controls.left then
            direction = 'e'
        end
    elseif direction == 'w' then
        if key == Controls.up and x - 1 >= 1 then
            x = x - 1
        elseif key == Controls.right then
            direction = 'n'
        elseif key == Controls.down and x+1<=width  then
            x = x + 1
        elseif key == Controls.left then
            direction = 's'
        end
    end
    return direction, x, y
end

return move
