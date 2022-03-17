local Door = require "house.door"
local targetCoor = coordinates("w", 3, 1)
local coor = coordinates("w", 1, 1)
local LivingRoom = Door("livingroom", targetCoor, coor, false)
return LivingRoom