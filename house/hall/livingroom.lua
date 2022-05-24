local Door = require "house.door"

local LivingroomDoor = Class {
    __includes = Door
}

function LivingroomDoor:init()
    local targetCoor = coordinates("w", 3, 1)
    Door.init(self, "livingroom", targetCoor, false)
end

return LivingroomDoor