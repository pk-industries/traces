Object = require "lib/classic"
require "navigate"
CreateRoom = Object:extend()

function CreateRoom:new(coords, name, d)
    self.name = name
    self.direction = d or "north"
    self.coords = coords

    self.n = love.graphics.newImage(coords[001])
    self.e = love.graphics.newImage(coords[002])
    self.s = love.graphics.newImage(coords[003])
    self.w = love.graphics.newImage(coords[004])

    self.enter = function()
        LOCATION = self.name
        DIRECTION = self.direction
        FRAME = self.n
        love.window.setTitle(self.name)
    end

    self.navigate = function()
        function love:keypressed(key)
            local next_d = Move(key, DIRECTION)
            DIRECTION = next_d
        end
        -- if next_d == "north" then
        --     DIRECTION = next_d
        --     FRAME = self.n
        -- elseif next_d == "east" then
        --     FRAME = self.e
        --     DIRECTION = next_d
        -- elseif next_d == "south" then
        --     FRAME = self.s
        --     DIRECTION = next_d
        -- elseif next_d == "west" then
        --     FRAME = self.w
        --     DIRECTION = next_d
        -- end
        -- return next_d
    end

end

return CreateRoom
