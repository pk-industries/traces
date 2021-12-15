local Room = require "libs.room"
local nightstand = require "house.bedroom.nightstand"
local ok, str
Bedroom =
    Class {
    _includes = Room,
    id = "bedroom",
    width = 2,
    height = 2,
    views = {},
    scenes = {
        -- ["e.2.2"] = nightstand,
        ["s.2.1"] = "bedroom.dresser",
        ["s.1.1"] = "bedroom.closet",
        ["w.1.2"] = "hall",
        ["n.2.2"] = "bedroom.bathoom"
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
    self.scenes["e.2.2"] = nightstand
    love.window.setTitle(GameState.current().id)
end
function Bedroom:update(dt)
    Timer.update(dt)
end
function Bedroom:draw()
    pcall(
        function()
            self.render(self)
        end
    )

    ok, str =
        pcall(
        function()
            if type(self.scene) == "table" then
                self.scene:draw()
            end
        end
    )
    if not ok then
        print(str)
    end
end

function Bedroom:keypressed(key)
    pcall(
        function()
            self.navigate(self, key)
        end,
        function(err)
            print(err)
        end
    )

    pcall(
        function()
            if type(self.scene) == "table" then
                self.scene:keypressed(key)
            end
        end
    )
end

function Bedroom:wheelmoved(x, y)
    if type(self.scene) == "table" then
        self.scene:wheelmoved(x, y)
    end
end

return Bedroom
