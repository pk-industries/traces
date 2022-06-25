local Room = require "house.room"

local Hall = Class {
    __includes = Room
 }

function Hall:init()
    Room.init(
        self, "hall", 1, 2, {
            ["w.1.1"] = require("house.hall.livingroom")(),
            ["n.1.2"] = require("house.hall.painting")(),
            ["e.1.1"] = require("house.hall.fusebox")(),
            ["e.1.2"] = require("house.hall.bedroom")(),
            ["w.1.2"] = require("house.hall.phone")()
        }, {}
    )
end

function Hall:keypressed(key)
    Room.keypressed(self, key)
    local d, x, y = Player:getPosition()
    if d == "s" and x == 1 and y == 2 then
        GameState.push(require "house.hall.hall_face")
    end
end

return Hall
