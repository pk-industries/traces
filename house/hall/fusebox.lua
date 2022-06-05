local SS = require("house.scenetemplates").SimpleScene

local FuseBox = Class { __includes = SS }

function FuseBox:init()
    SS.init(self, "hall.fusebox", false, "assets/images/hall/fusebox.png")
    self.pos = 0
end

function FuseBox:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    SS.keypressed(self, key)
end

return FuseBox