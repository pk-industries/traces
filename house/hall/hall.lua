local Room = require "house.room"

local Hall = Class { __includes = Room }

function Hall:init()
    Room.init(
        self,
        "hall",
        1,
        2,
        {
            ["e.1.2"] = require("house.hall.bedroom")(),
            ["w.1.1"] = require("house.hall.livingroom")()
        },
        {}
    )
end

function Hall:enter()
    System.setTitle("Hall")
end

return Hall
