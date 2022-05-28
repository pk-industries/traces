local Room = require "house.room"
local Closet = Class {
    __includes = Room
}

function Closet:init()
    Room.init(
        self,
        "closet",
        1,
        1,
        {
            ["n.1.1"] = require("house.closet.bedroom")()
        },
        {}
    )
end

function Closet:enter()
    Room.enter(self)
    System.setTitle("Closet")
end

return Closet
