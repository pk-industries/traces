local Door = require "house.door"

local ClosetDoor = Class {
    __includes = Door
}

function ClosetDoor:init()
    local closetCoor = coordinates("s", 1, 1)
    Door.init(self, "closet", closetCoor, true)
    self.openSnd = "assets/sounds/door_creak.wav"
end

return ClosetDoor