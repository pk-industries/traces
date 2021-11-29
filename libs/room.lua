local Room = Class {__includes = Saveable}

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
end

function Room:navigate(key)
    if GamePad.includes[key] then
        Player:move(key)
    end

    if type(Player.scene) == "function" then
        Player.scene()
    end

    if key == Controls.a and Player.scene then
        print(Player.scene)
        GameState.push(House[Player.scene])
    end
end

return Room
