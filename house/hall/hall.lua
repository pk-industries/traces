local Room = require "house.room"

local Hall = Class { __includes = Room }

function Hall:init()
    Room.init(
        self,
        "hall",
        1,
        2,
        {
            ["w.1.1"] = require("house.hall.livingroom")(),
            ["n.1.2"] = require("house.hall.painting")(),
            ["e.1.2"] = require("house.hall.bedroom")(),
            ["w.1.2"] = require("house.hall.phone")()
        },
        {}
    )
end

function Hall:enter()
    System.setTitle("Hall")
    Room.enter(self)
end

return Hall
