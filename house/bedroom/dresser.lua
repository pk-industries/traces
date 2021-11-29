local MusicBox = require "house.bedroom.musicbox"

local Dresser = Scene("bedroom.dresser")
function Dresser:init()
end

function Dresser:draw()
    local img = love.graphics.newImage("assets/images/bedroom/dresser.png")
    local scale = WINDOW.scale
    love.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Dresser:keypressed(key)
    if key == GamePad.up and love.keyboard.isDown(GamePad.left) then
        GameState.push(MusicBox)
    end
    if key == Controls.b then
        GameState.pop()
    end
end

return Dresser
