local Room = require "house.room"

local Livingroom = Class { __includes = Room }

function Livingroom:init()
    Room.init(
        self,
        "livingroom",
        3,
        3,
        {
            ["w.1.1"] = require("house.livingroom.kitchen")(),
            ["n.1.3"] = require("house.livingroom.coatcloset")(),
            ["e.3.1"] = require("house.livingroom.hall")(),
            ["w.3.2"] = require("house.livingroom.couch")()
        },
        { "e.1.2", "n.2.1", "s.2.3", "w.3.2" }
    )
end

function Livingroom:enter()
    Room.enter(self)
    System.setTitle "Living Room"
end

return Livingroom