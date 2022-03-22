local Room = require "house.room"

local Kitchen = Class { __includes = Room }

function Kitchen:init()
    Room.init(
        self,
        "kitchen",
        1,
        1,
        {
            ["e.1.1"] = require("house.kitchen.livingroom")()
        },
        {}
    )
end

function Kitchen:enter()
    System.setTitle("Kitchen")
end

return Kitchen