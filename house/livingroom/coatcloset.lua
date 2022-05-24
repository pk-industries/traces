local ImageExplorer = require("house.scenetemplates").ImageExplorer

local CoatCloset = Class { __includes = ImageExplorer }

function CoatCloset:init()
    ImageExplorer.init(self, "livingroom.coatcloset", "n", 1, 3, false, "assets/images/livingroom/coatcloset/coatcloset_base.png")
end

function CoatCloset:drawDebug()
    local g = System.graphics
    g.setFont(Fonts.pixel[30])
    g.setColor(1, 1, 1)
    g.print("Scene " .. self.id, 0, 0)
end

return CoatCloset