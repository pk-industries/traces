local Door = require "house.door"
local hallCoor = coordinates("w", 1, 2)
local coor = coordinates("w", 1, 2)
local Hall = Door("hall", hallCoor, coor, false)
return Hall