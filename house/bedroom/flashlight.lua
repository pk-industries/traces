local SS = require("house.scenetemplates").SimpleScene

local Flashlight = Class { __includes = SS }

local prompt

function Flashlight:init()
    SS.init(self, "bedroom.flashlight", false, "assets/images/bedroom/flashlight.png")
    prompt = require("house.overlays.flashingprompt")("A", 292, 124)
    self.offset = 0
end

function Flashlight:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    SS.keypressed(self, key)
end

return Flashlight