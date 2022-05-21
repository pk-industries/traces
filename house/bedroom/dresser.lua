local MusicBox = require "house.bedroom.musicbox"
local Dresser = Class {__includes = Scene}
local img

function Dresser:init()
    Scene.init(self, "bedroom.dresser", "s", 2, 1, false)
end

function Dresser:enter()
    img = System.graphics.createImage("assets/images/bedroom/dresser.png")
end

function Dresser:draw()
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
    Scene.draw(self)
end

function Dresser:update()
    if System.keyboard.isDown(Controls.up) and System.keyboard.isDown(Controls.left) then
        GameState.push(MusicBox)
    end
end

function Dresser:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    Scene.keypressed(self, key)
end

return Dresser