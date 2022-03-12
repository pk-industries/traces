local MusicBox = require "house.bedroom.musicbox"

local Dresser = Scene("bedroom.dresser")
function Dresser:init()
end

function Dresser:draw()
    local img = System.graphics.createImage("assets/images/bedroom/dresser.png")
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Dresser:keypressed(key)
    if key == GamePad.up and System.keyboard.isDown(GamePad.left) then
        GameState.push(MusicBox)
    end
    if key == Controls.b then
        GameState.pop()
    end
end

return Dresser
