local SimpleScene = require("house.scenetemplates").SimpleScene

local Window = Class { __includes = SimpleScene }

function Window:init()
    SimpleScene.init(self, "bedroom.window", false, "assets/images/bedroom/window_bedroom.png")
end

function Window:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Window