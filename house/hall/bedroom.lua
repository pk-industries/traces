local Door = require "house.door"

local BedroomDoor = Class {
    __includes = Door
}

function BedroomDoor:init()
    local bedCoor = coordinates("e", 1, 2)
    local coor = coordinates("e", 1, 2)
    Door.init(self, "bedroom", bedCoor, coor, true)
end

return BedroomDoor