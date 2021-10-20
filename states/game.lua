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
    x = 2,
    sx = love.graphics.getWidth() / 2,
    --The center x point
    sy = love.graphics.getHeight() / 2,
    --The center y point
    ox = 0,
    oy = 1,
    zoom = 1
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

-- local img = img --Your image
-- local imgW = img:getWidth() --Get your image size
-- local imgH = img:getHeight() --Get your image size
-- local zoom = n --Your zoom factor (to zoom in, must be bigger than 1)

--if you want it based on position:
-- love.graphics.draw(img, posx - (imgW * zoom / 2), posy - (imgH * zoom / 2), 0, zoom, zoom)

function game:init()
    local save = table.load("save.lua")
    if save then
        for k, v in pairs(save) do
            game[k] = v
        end
    end
end

--- /path/to/your/img.png
---@return string
function game.imgPath(self)
    local imgDir = "assets/images/prototype"
    local path =
        imgDir ..
        "/" .. self.room .. "/" .. "x" .. self.x .. "y" .. self.y .. "_" .. self.direction .. "_" .. self.room .. ".png"
    return path
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

function game.debugTxt(self)
    local stats = {
        "room: " .. self.room,
        "direction: " .. self.direction,
        "x: " .. self.x,
        "y: " .. self.y
    }
    if game:facingExit() then
        table.insert(stats, "facing exit: " .. game:facingExit())
    end
    local msg = ""
    for _, val in ipairs(stats) do
        msg = msg .. val .. "\n"
    end
    return msg
end

function game:enter()
end

function game:leave()
    local errMsg =
        table.save({["room"] = game.room, ["direction"] = game.direction, ["x"] = game.x, ["y"] = game.y}, "save.lua")

    if errMsg then
        print("file not created: " .. errMsg)
    end
end

function game:update(dt)
    local facing = game:facingExit()
    if facing then
        game.prompt = "Press " .. facing .. " to enter " .. facing .. " room"
    -- print(game.prompt)
    end
end

function game:keypressed(key, code)
    local stats = {
        "room: " .. self.room,
        "direction: " .. self.direction,
        "x: " .. self.x,
        "y: " .. self.y
    }
    if game:facingExit() then
        table.insert(stats, "facing exit: " .. game:facingExit())
    end
    local msg = ""
    for _, val in ipairs(stats) do
        -- print(val)
    end

    game.zoom = 1
end

function game:keyreleased(key, code)
    -- game.kx = 1
    -- game.ky = 1
    if key == Controls.pause then
        GameState.switch(States.pause)
    else
        game:move(key)
    end
end

function game:mousepressed(x, y, mbutton)
end

function game:draw()
    love.graphics.setFont(Fonts.monospace[12])
    local filePath = game:imgPath()
    local img = love.graphics.newImage(filePath)
    local imgW = img:getWidth()
    local imgH = img:getHeight()
    local zoom = game.zoom
    love.graphics.draw(img, 0, 0)
    -- love.graphics.draw(img, game.sx - (imgW * zoom / 2), game.sy - (imgH * zoom / 2), 0, zoom, zoom)
end

return game
