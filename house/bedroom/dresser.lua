local SimpleScene = require("house.scenetemplates").SimpleScene
local MusicBox = require "house.bedroom.musicbox"
local Dresser = Class {__includes = SimpleScene}
local prompt

function Dresser:init()
    SimpleScene.init(self, "bedroom.dresser", false, "assets/images/bedroom/dresser.png")
    prompt = require("house.flashingprompt")("PlaceHolder", 292, 124)
end

function Dresser:enter()
    prompt.on = true
    SimpleScene.enter(self)
end

function Dresser:draw()
    SimpleScene.draw(self)
    prompt:routine()
end

function Dresser:keypressed(key)
    if key == Controls.up then
        GameState.push(MusicBox)
    elseif key == Controls.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Dresser