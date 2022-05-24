local SimpleScene = require("house.scenetemplates").SimpleScene

local Pictures = Class { __includes = SimpleScene }

function Pictures:init()
    SimpleScene.init(self, "bedroom.pictures", false, "assets/images/bedroom/pictures.png")
end

function Pictures:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    SimpleScene.keypressed(self, key)
end

return Pictures