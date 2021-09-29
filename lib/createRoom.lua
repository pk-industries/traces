local class = require("lib/classic")
local newImage = love.graphics.newImage
local move = require("lib/move")

CreateRoom = class:extend()

function CreateRoom:new(name, entrance, images, exits, about)
    self.name = name
    self.entrance = entrance
    self.about = about
    self.coordinates = {}
    self.location = self.entrance
    self.north = newImage(images[001])
    self.east = newImage(images[002])
    self.south = newImage(images[003])
    self.west = newImage(images[004])
    self.exits = exits
end

function CreateRoom:update(dt)
end

function CreateRoom:draw()
    local frame = self[self.location]
    love.graphics.draw(frame, 0, 0)
end

function CreateRoom:keypressed(key)
    print()
    local nextRoomName = self.exits[self.location]
    local nextRoom = rooms[nextRoomName] or false

    if key == enter_key and nextRoomName and nextRoom then
        game = nextRoom
    end


    self.location = move(key, self.location)
    -- print(self.exits[self.location])
    if self.location == nil then
    end
end

return CreateRoom
