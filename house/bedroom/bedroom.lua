local TraceRoom = require "house.traceroom"
local bathroom = require "house.bedroom.bathroom"
local closet = require "house.bedroom.closet"
local dresser = require "house.bedroom.dresser"
local hall = require "house.bedroom.hall"
local nightstand = require "house.bedroom.nightstand"
local Bedroom = Class { __includes = TraceRoom }

function Bedroom:init()
    TraceRoom.init(
        self,
        "bedroom",
        2,
        2,
        {
            ["e.2.2"] = nightstand,
            ["s.2.1"] = dresser,
            ["s.1.1"] = closet,
            ["w.1.2"] = hall,
            ["n.2.2"] = bathroom
        },
        {
            ["2.1"] = "2.2",
            ["2.2"] = "2.1"
        }
    )
end

function Bedroom:enter()
    System.setTitle("Bedroom")
end

return Bedroom