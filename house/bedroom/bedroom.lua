local Room = require  "house.room"
local Bedroom = Class { __includes = Room }

function Bedroom:init()
    Room.init(
        self,
        "bedroom",
        2,
        2,
        {
            ["e.2.2"] = require ("house.bedroom.nightstand")(),
            ["s.2.1"] = require ("house.bedroom.dresser")(),
            ["s.1.1"] = require ("house.bedroom.closet")(),
            ["w.1.2"] = require ("house.bedroom.hall")(),
            ["n.2.2"] = require ("house.bedroom.bathroom")()
        },
        { "n.2.1", "s.2.2" }
    )
end

function Bedroom:enter()
    System.setTitle("Bedroom")
end

return Bedroom