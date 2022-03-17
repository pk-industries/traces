local Saveable = require "libs.saveable"

Room = Class {__includes = Saveable}

function Room:init(id)
    Saveable.init(self, id or "room")
end

function Room:render()
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/"
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = WINDOW.scale
    System.graphics.setColor(255, 255, 255)
    if System.filesystem.checkExists(filepath) then
        System.graphics.draw(System.graphics.createImage(filepath), 0, 0, 0, scale, scale)
    else
        local id = self.id
        local altpath = roomdir .. "x" .. x .. "y" .. y .. "_" .. id .. ".png"
        if System.filesystem.checkExists(altpath) then
            local offsetTbl = {
                ["n"] = 0,
                ["s"] = 400,
                ["e"] = 800,
                ["w"] = 1200
            }
            local offset = offsetTbl[d]
            System.graphics.draw(System.graphics.createImage(altpath), 0, 0, 0, scale, scale, offset)
        else
            error("File: " .. altpath .. " does not exist")
        end
    end
end

function Room:navigate(key)
    if key == "`" then
        self.debug = not self.debug
    elseif GamePad.includes[key] then
        Player:move(key)
    end
end

return Room
