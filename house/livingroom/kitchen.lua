local Door = require "house.door"

local Kitchen = Class {
    __includes = Door
}

function Kitchen:init()
    local targetCoor = coordinates("w", 1, 1)
    Door.init(self, "kitchen", targetCoor, false)
end

return Kitchen