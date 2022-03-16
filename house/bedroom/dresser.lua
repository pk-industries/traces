local MusicBox = require "house.bedroom.musicbox"
local Dresser = Class {__includes = Scene}

function Dresser:init()
    Scene.init(self, "bedroom.dresser", "s", 2, 1, false, false)
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

return Dresser()