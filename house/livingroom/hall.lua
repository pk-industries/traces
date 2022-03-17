local Door = require "house.door"
local targetCoor = coordinates("e", 1, 1)
local coor = coordinates("e", 3, 1)
local Hall = Door("hall", targetCoor, coor, false)
return Hall