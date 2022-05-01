local Door = require "house.door"

local ClosetDoor = Class {
    __includes = Door
}

function ClosetDoor:init()
    local closetCoor = coordinates("s", 1, 1)
    local coor = coordinates("n", 1, 1)
    Door.init(self, "closet", closetCoor, coor, true)
end

return ClosetDoor