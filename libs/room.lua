local Saveable = require "libs.saveable"

Room = Class {__includes = Saveable}

function Room:init(id)
    Saveable.init(self, id or "room")
    self.info = {}
end

function Room:render()
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/"
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = WINDOW.scale
    System.setColor(255, 255, 255)
    if System.filesystem.checkExists(filepath) then
        System.graphics.draw(System.graphics.createImage(filepath), 0, 0, 0, scale, scale)
    else
        error("File: " .. filepath .. " does not exist")
    end

    if self.debug then
        local cs = GameState:current()
        local str = ""
        for k, v in pairs(cs.views) do
            str = str .. v .. "\n"
        end
        debug.getinfo(
            Inspect(Room.info) .. "\n",
            self.id,
            Player:__tostring(),
            "\n",
            Inspect({id = cs.id, scenes = cs.scene, obsticals = cs.obsticals}),
            str
        )
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