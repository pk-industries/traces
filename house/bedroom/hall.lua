local Door = require "house.door"

local HallDoor = Class {
    __includes = Door
}

function HallDoor:init()
    local hallCoor = coordinates("w", 1, 2)
    Door.init(self, "hall", hallCoor, true)
    self.openSnd = "assets/sounds/doorknob.wav"
    -- self.lockedSnd = "assets/sounds/door-locked.m4a"
end

return HallDoor