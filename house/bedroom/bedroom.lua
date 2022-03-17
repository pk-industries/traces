local Room = require "house.room"
local Bedroom = Class { __includes = Room }

function Bedroom:init()
    Room.init(
        self,
        "bedroom",
        2,
        2,
        {
            ["e.2.2"] = require "house.bedroom.nightstand",
            ["s.2.1"] = require "house.bedroom.dresser",
            ["s.1.1"] = require "house.bedroom.closet",
            ["w.1.2"] = require "house.bedroom.hall",
            ["n.2.2"] = require "house.bedroom.bathroom"
        },
        {
            ["2.1"] = { "n" },
            ["2.2"] = { "s" }
        }
    )
end

function Bedroom:enter()
    System.setTitle("Bedroom")
end

return Bedroom