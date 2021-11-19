require "house.room"
local MusicBox = require "house.bedroom.musicbox"

local Dresser =
    Child(
    "dresser",
    "s",
    2,
    1,
    {
        init = function(self)
        end,
        update = function(self)
        end,
        enter = function(self)
            print(self.id .. ": init()")
        end,
        draw = function(self)
            local img = love.graphics.newImage("assets/images/bedroom/dresser_bedroom.png")
            local scale = CONFIG.window.scale
            love.graphics.draw(img, 0, 0, 0, scale, scale)
        end,
        leave = function(self)
            print(self.id .. ": leave()")
        end,
        keypressed = function(self, key)
            if key == Controls.up and love.keyboard.isDown(Controls.left) then
                GameState.push(MusicBox)
            end
            if key == Controls.back then
                GameState.pop()
            end
        end
    }
)

return Dresser
