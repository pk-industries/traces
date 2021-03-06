local Door = require "house.door"

local LivingroomDoor = Class {
    __includes = Door
}

function LivingroomDoor:init()
    local targetCoor = coordinates("e", 1, 1)
    Door.init(self, "livingroom", targetCoor, false)
end

return LivingroomDoor