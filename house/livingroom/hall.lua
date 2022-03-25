local Door = require "house.door"

local HallDoor = Class {
    __includes = Door
}

function HallDoor:init()
    local targetCoor = coordinates("e", 1, 1)
    local coor = coordinates("e", 3, 1)
    Door.init(self, "hall", targetCoor, coor, false)
end

return HallDoor
