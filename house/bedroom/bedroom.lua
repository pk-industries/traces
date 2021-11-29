local Scene = require "libs.scene"
local Room = require "libs.room"

Bedroom =
    Class {
    _includes = Room,
    id = "bedroom",
    width = 2,
    height = 2,
    views = {},
    scenes = {
        ["e.2.2"] = require "house.bedroom.radio",
        ["s.2.1"] = require "house.bedroom.dresser",
        ["s.1.1"] = Scene("bedroom.closet"),
        ["w.1.2"] = Scene("hallway"),
        ["n.2.2"] = Scene("bedroom.bathoom")
    },
    obsticals = {
        ["2.1"] = "2.2",
        ["2.2"] = "2.1"
    }
}

Bedroom:include(Room)

local color
function Bedroom:init()
end
function Bedroom:enter()
    color = Colors.black

    love.window.setTitle(GameState.current().id)
    Signal.emit("player.position-check")
end
function Bedroom:update(dt)
    Timer.update(dt)
end
function Bedroom:draw()
    xpcall(
        function()
            self.render(self)
        end,
        function(err)
            print(err)
        end
    )
end

function Bedroom:keypressed(key)
    xpcall(
        function()
            self.navigate(self, key)
        end,
        function(err)
            print(err)
        end
    )
end

function Bedroom:leave()
end

return Bedroom
