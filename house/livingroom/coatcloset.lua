local scenes = require "house.scenetemplates"
local ImageExplorer = scenes.ImageExplorer
local CoatCloset = Class { __includes = ImageExplorer }

function CoatCloset:init()
    ImageExplorer.init(self, "livingroom.coatcloset", "n", 1, 3, false, "assets/images/livingroom/coatcloset/coatcloset_base.png")
end

return CoatCloset