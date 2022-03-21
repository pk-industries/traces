local Door = require "house.door"

local HallDoor = Class {
    __includes = Door
}

function HallDoor:init()
    local hallCoor = coordinates("w", 1, 2)
    local coor = coordinates("w", 1, 2)
    Door.init(self, "hall", hallCoor, coor, true)
end

return HallDoor