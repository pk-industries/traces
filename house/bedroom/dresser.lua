local SimpleScene = require("house.scenetemplates").SimpleScene
local MusicBox = require "house.bedroom.musicbox"
local Dresser = Class {__includes = SimpleScene}

function Dresser:init()
    SimpleScene.init(self, "bedroom.dresser", false, "assets/images/bedroom/dresser.png")
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
    SimpleScene.keypressed(self, key)
end

return Dresser