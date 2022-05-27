local SimpleScene = require("house.scenetemplates").SimpleScene

local Sticky = Class { __includes = SimpleScene }

function Sticky:init()
    SimpleScene.init(self, "bedroom.sticky", false, "assets/images/bedroom/stickynote.png")
end

function Sticky:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Sticky