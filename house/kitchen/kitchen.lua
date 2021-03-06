local Room = require "house.room"

local Kitchen = Class { __includes = Room }

function Kitchen:init()
    Room.init(
        self,
        "kitchen",
        1,
        3,
        {
            ["e.1.1"] = require("house.kitchen.livingroom")()
        },
        {}
    )
end

function Kitchen:enter()
    Room.enter(self)
    System.setTitle("Kitchen")
end

return Kitchen