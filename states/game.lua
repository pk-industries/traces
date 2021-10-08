local move = require "utils.move"
local rooms = require "rooms"

---@class game
---@field room string
---@field x number
local game = {
    room = "bedroom",
    direction = "n",
    y = 1,
    x = 2
}

local initialState = {}

local function locationFrame(room, direction, x, y)
    local imgDir = "assets/images/prototype"
    local imgPath = imgDir .. "/" .. room .. "/" .. "x" .. x .. "y" .. y .. "_" .. direction .. "_" .. room .. ".png"
    return love.graphics.newImage(imgPath)
end

function game:init()
    local state = love.filesystem.load("save.json")

    if state then
        for k, v in pairs(state) do
            game[k] = v
        end
    else
        for k, v in pairs(initialState) do
            game[k] = v
        end
    end
end

function game:enter()
end

function game:leave()
    love.filesystem.write("save.json", game)
    print("Saved game state")
end

function game:update(dt)
end

function game:keypressed(key, code)
    local room = rooms[game.room]
    game.direction, game.x, game.y = move(key, game.direction, game.x, game.y, room.width, room.height)
end

function game:mousepressed(x, y, mbutton)
end

function game:draw()
    local img = locationFrame(game.room, game.direction, game.x, game.y)
    love.graphics.draw(img, 0, 0)
    love.graphics.printf(game.room, 100, 0, 200, "center")
end

return game
