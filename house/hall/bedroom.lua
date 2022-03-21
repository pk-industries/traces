local Door = require "house.door"
local targetCoor = coordinates("e", 1, 2)
local coor = coordinates("e", 1, 2)
local Bedroom = Door("bedroom", targetCoor, coor, true)
return Bedroom