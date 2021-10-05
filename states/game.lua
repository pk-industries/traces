 local move = require "utils.move"
local game = {}

local initialState = {
    room = 'bedroom',
    direction = 'n',
    y = 1,
    x = 2,
}

local function locationFrame(room, direction, x, y)
   local imgDir = 'assets/images/prototype'
   local imgPath = imgDir .. '/' .. room .. '/' .. 'x' .. x ..'y' ..y .. '_' .. direction .. '_' .. room .. '.png'
   return love.graphics.newImage(imgPath)
end

local makeRoom = require 'utils.makeRoom'
--  assert(TableSave)

function game:init()
    local state  = love.filesystem.load('save.json')

    if state then
       for k,v in pairs(state) do game[k] = v end
    else
        for k,v in pairs(initialState) do game[k] = v end

    end
    print(Inspect(game))
end

local room = makeRoom('bedroom', 2, 2)


function game:enter()
end

function game:update(dt)
end

function game:keypressed(key, code)

       game.direction =  move(key, game.direction)
end

function game:mousepressed(x, y, mbutton)
end

function game:draw()
    local img = locationFrame(game.room,game.direction,game.x,game.y)
    love.graphics.draw(img, 0, 0)
    love.graphics.printf(game.room,100, 0, 200,"center")
end

return game
