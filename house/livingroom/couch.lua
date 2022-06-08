local SimpleScene = require("house.scenetemplates").SimpleScene

local Couch = Class { __includes = SimpleScene }

function Couch:init()
    SimpleScene.init(self, "livingroom.couch", false, "assets/images/livingroom/x2y2_livingroom.png")
end

function Couch:keypressed(key)
    if key == Controls.up then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Couch