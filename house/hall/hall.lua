local Room = require "house.room"
local bedroom = require "house.hall.bedroom"
local livingroom = require "house.hall.livingroom"

local Hall = Class { __includes = Room }

function Hall:init()
    Room.init(
        self,
        "hall",
        1,
        2,
        {
            ["e.1.2"] = bedroom,
            ["w.1.1"] = livingroom
        },
        {}
    )
end

function Hall:enter()
    System.setTitle("Hall")
end

return Hall
