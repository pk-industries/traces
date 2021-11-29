local Room = Class {_includes = Saveable}

function Room:render()
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/" --- /assets/images/bedroom/
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = WINDOW.scale
    love.graphics.setColor(255, 255, 255)
    if FileExists(filepath) then
        love.graphics.draw(love.graphics.newImage(filepath), 0, 0, 0, scale, scale)
    else
        error("File: " .. filepath .. " does not exist")
    end

    --

    local stats = {
        id = GameState.current().id,
        direction = d,
        x = x,
        y = y
    }
    if type(Player.scene) == "table" then
        stats.scene = Player.scene.id
    end
end

function Room:navigate(key)
    if Controls.arrowkeys[key] then
        Player:move(key)
    end

    if key == Controls.enter and Player.scene then
        print(Player.scene.id)
        GameState.push(Player.scene)
    end
end

return Room
