---@class game
---@field room RoomName
---@field direction Direction
---@field x number
local game = {
    room = "bedroom",
    direction = "n",
    y = 1,
    x = 2
}

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

---@param key love.KeyConstant
---@param code number
function game:keypressed(key, code)
    if key == Controls.pause then
        State.switch(States.pause)
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
    love.graphics.draw(img, 0, 0)
    love.graphics.setColor(Colors.white)
    love.graphics.printf({Colors.black, game:debugTxt()}, 0, 0, love.graphics.getWidth(), "center")
end

return game
