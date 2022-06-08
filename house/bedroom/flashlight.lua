local SS = require("house.scenetemplates").SimpleScene

local Flashlight = Class { __includes = SS }

local prompt

function Flashlight:init()
    SS.init(self, "bedroom.flashlight", false, "assets/images/bedroom/flashlight.png")
    prompt = require("house.overlays.flashingprompt")("A", 151, 104)
end

function Flashlight:enter()
    prompt.on = true
    SS.enter(self)
end

function Flashlight:draw()
    SS.draw(self)
    prompt:routine()
end

function Flashlight:keypressed(key)
    if key == Controls.a then
        self.img.x = self.img.x == 0 and WINDOW.baseW or 0
    elseif key == Controls.down then
        GameState.pop()
    end
    SS.keypressed(self, key)
end

return Flashlight