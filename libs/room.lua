local Saveable = require "libs.saveable"

Room = Class {__includes = Saveable}

function Room:init(id)
    Saveable.init(self, id or "room")
    self.info = {}
end

function Room:render()
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/" --- /assets/images/bedroom/
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = WINDOW.scale
    love.graphics.setColor(255, 255, 255)
    if FileExists(filepath) then
        love.graphics.draw(love.graphics.newImage(filepath), 0, 0, 0, scale, scale)
    else
        error("File: " .. filepath .. " does not exist")
    end

    if self.debug then
        local cs = GameState:current()
        str = ""
        for k, v in pairs(GameState.current().views) do
            str = str .. v .. "\n"
        end
        info(
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
    else
        print("Unknown key pressed: " .. key)
        Player:save()
    end
end

return Room