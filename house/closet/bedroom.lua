local Door = require "house.door"

local BedroomDoor = Class {
    __includes = Door
}

function BedroomDoor:init()
    local bedCoor = coordinates("n", 1, 1)
    local coor = coordinates("s", 1, 1)
    Door.init(self, "bedroom", bedCoor, coor, true)
end

return BedroomDoor