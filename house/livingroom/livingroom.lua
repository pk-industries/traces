local Room = require "house.room"

local Livingroom = Class { __includes = Room }

function Livingroom:init()
    Room.init(
        self,
        "livingroom",
        3,
        3,
        {
            ["e.3.1"] = require "house.livingroom.hall",
            ["a.2.2"] = require "house.livingroom.couch"
        },
        {}
    )
end

function Livingroom:enter()
    System.setTitle "Living Room"
end

return Livingroom