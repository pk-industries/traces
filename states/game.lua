---@class game
---@field room RoomName
---@field direction Direction
---@field x number
---@field keyreleased love.keyreleased
---@field keypressed love.keypressed
---@field mousepressed love.mousepressed
---@field mousereleased love.mousereleased
---@field mousemoved love.mousemoved
---@field update love.update
---@field draw love.draw
---@field sx love.draw
local game = {
    room = "bedroom",
    direction = "n",
    y = 1,
    x = 2
}

function game.frame(self)
    local img = love.graphics.newImage(self:imgPath())
    local imgW, imgH = img:getDimensions()
    local posx = love.graphics.getWidth() / 2
    --The center x point
    local posy = love.graphics.getHeight() / 2
    --The center y point
    local ox = 0
    local oy = 1
    local zoom = 1
    local sx = posx - (imgW * zoom / 2)
    local sy = posy - (imgH * zoom / 2)
    return img, sx, sy, 0, zoom, zoom
end

function game:init()
    local save = table.load("save.lua")
    if save then
        for k, v in pairs(save) do
            game[k] = v
        end
    end
end

---@param self game
--- /path/to/your/img.png
---@return string
function game.imgPath(self)
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. self.room .. "/" --- /assets/images/bedroom/
    local filename = "x" .. self.x .. "y" .. self.y .. "_" .. self.direction .. "_" .. self.room .. ".png"

    local filepath = roomdir .. filename

    if love.filesystem.getInfo(filepath) then
        return filepath
    else
        print("File not found: " .. filepath)
        return roomdir .. "x1y1_n_" .. self.room .. ".png"
    end
end

game.move = require "utils.move"

function game.facingExit(self)
    local exits = Rooms[self.room].exits
    local facing = nil
    for k, v in pairs(exits) do
        local wall, x, y = v.wall, v.x, v.y
        if wall == self.direction and x == self.x and y == self.y then
            return k
        end
    end
    return facing
end

function game:enter()
end

function game:leave()
end

function game:update(dt)
end

function game:keypressed(key, code)
    if key == Controls.pause then
        GameState.switch(States.pause)
    else
        game:move(key)
    end
end

function game:keyreleased(key, code)
end

function game:draw()
    love.graphics.setFont(Fonts.monospace[12])
    local filePath = game:imgPath()
    local img = love.graphics.newImage(filePath)
    love.graphics.draw(img, 0, 0, 0, CONFIG.window.scale, CONFIG.window.scale)
end

return game

--   local imgW = img:getWidth()
--     local imgH = img:getHeight()
--     local zoom = game.zoom
-- love.graphics.draw(img, game.sx - (imgW * zoom / 2), game.sy - (imgH * zoom / 2), 0, zoom, zoom)
-- local img = img --Your image
-- local imgW = img:getWidth() --Get your image size
-- local imgH = img:getHeight() --Get your image size
-- local zoom = n --Your zoom factor (to zoom in, must be bigger than 1)

--if you want it based on position:
-- love.graphics.draw(img, posx - (imgW * zoom / 2), posy - (imgH * zoom / 2), 0, zoom, zoom)
