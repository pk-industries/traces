local class = require("lib/classic")
local move = require("lib/move")
local newImage = love.graphics.newImage

CreateRoom = class:extend()

function CreateRoom:new(name, images, exits, about)
    self.name = name
    self.about = about
    self.north = newImage(images[001])
    self.east = newImage(images[002])
    self.south = newImage(images[003])
    self.west = newImage(images[004])
    self.exits = exits
end

function CreateRoom:update(dt)
end

function CreateRoom:draw()
    local frame = self[player.facing]
    love.graphics.draw(frame, 0, 0)
end

function CreateRoom:keypressed(key)
    local nextRoomName = self.exits[player.facing]
    local nextRoom = rooms[nextRoomName] or false

    if key == enter_key and nextRoomName and nextRoom then
        game = nextRoom
    end

    player.facing = move(key)
end

return CreateRoom
