local SimpleScene = require("house.scenetemplates").SimpleScene
local MusicBox = require "house.bedroom.musicbox"
local FlashScene = require "house.bedroom.flashlight"
local Dresser = Class {__includes = SimpleScene}
local prompt

function Dresser:init()
    SimpleScene.init(self, "bedroom.dresser", false, "assets/images/bedroom/dresser.png")
    prompt = require("house.overlays.flashingprompt")("A", 292, 124)
    self.flags.flashObtained = false
    self.offset = 0
end

function Dresser:enter()
    prompt.on = self.flags.flashObtained ~= true
    self.offset = self.flags.flashObtained and WINDOW.baseW or 0
    SimpleScene.enter(self)
end

function Dresser:draw()
    SimpleScene.draw(self)
    prompt:routine()
end

function Dresser:keypressed(key)
    if key == Controls.up then
        GameState.push(MusicBox)
    elseif not self.flags.flashObtained and key == Controls.a then
        GameState.push(FlashScene)
    elseif key == Controls.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Dresser