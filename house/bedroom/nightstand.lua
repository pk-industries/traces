local SimpleScene = require("house.scenetemplates").SimpleScene
local Radio = require "house.bedroom.radio"

local NightStand = Class {
    __includes = SimpleScene
 }
local prompt

function NightStand:init()
    SimpleScene.init(
        self, "bedroom.nightstand", false,
        "assets/images/bedroom/Nightstand.png"
    )
    prompt = require("house.overlays.flashingprompt")("A", 199, 201)
    self.flags.paperUnlocked = false
    self.isOpen = false
end

function NightStand:draw()
    SimpleScene.draw(self)
    prompt:routine()
end

function NightStand:keypressed(key)
    if key == GamePad.up then
        GameState.push(Radio)
    elseif key == Controls.a then
        self.isOpen = not self.isOpen
        self.img.path = self.isOpen and
                            "assets/images/bedroom/nightstand_open.png" or
                            "assets/images/bedroom/Nightstand.png"
        self.img.image = System.graphics.createImage(self.img.path)
    elseif key == GamePad.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

function NightStand:update()
    prompt.on = not self.flags.paperUnlocked and not self.isOpen
    SimpleScene.update(self)
end

return NightStand
