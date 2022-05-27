local SimpleScene = require("house.scenetemplates").SimpleScene

local Painting = Class { __includes = SimpleScene }

function Painting:init()
    SimpleScene.init(self, "hall.painting", false, "assets/images/hall/hall_painting.png")
end

function Painting:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Painting