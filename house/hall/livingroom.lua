local Door = require "house.door"

local LivingroomDoor = Class {
    __includes = Door
}

function LivingroomDoor:init()
    local targetCoor = coordinates("w", 3, 1)
    local coor = coordinates("w", 1, 1)
    Door.init(self, "livingroom", targetCoor, coor, false)
end

return LivingroomDoor