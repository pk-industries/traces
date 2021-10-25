---@param game game
---@param key love.KeyConstant
local function move(game, key)
    local room = Rooms[game.room]
    local direction, x, y = game.direction, game.x, game.y
    local height, width = room.height, room.width

    if direction == "n" then
        if key == Controls.up and y + 1 <= height then
            game.y = y + 1
        elseif key == Controls.right then
            game.direction = "e"
        elseif key == Controls.down and y - 1 >= 1 then
            game.y = y - 1
        elseif key == Controls.left then
            game.direction = "w"
        end
    elseif direction == "e" then
        if key == Controls.up and x + 1 <= width then
            game.x = x + 1
        elseif key == Controls.right then
            game.direction = "s"
        elseif key == Controls.down and x - 1 >= height then
            x = x - 1
        elseif key == Controls.left then
            game.direction = "n"
        end
    elseif direction == "s" then
        if key == Controls.up and y - 1 >= 1 then
            game.y = y - 1
        elseif key == Controls.right then
            game.direction = "w"
        elseif key == Controls.down and y + 1 <= height then
            game.y = y + 1
        elseif key == Controls.left then
            game.direction = "e"
        end
    elseif direction == "w" then
        if key == Controls.up and x - 1 >= 1 then
            game.x = x - 1
        elseif key == Controls.right then
            game.direction = "n"
        elseif key == Controls.down and x + 1 <= width then
            game.x = x + 1
        elseif key == Controls.left then
            game.direction = "s"
        end
    end
    print(game.room .. " " .. game.x .. " " .. game.y .. " " .. game.direction)
end

return move
