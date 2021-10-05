local game = {}

local initialDirection = {
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

    local state = {}
    if love.filesystem.load('save.json') then
        state = love.filesystem.load('save.json')()
    else
        state.location = initialDirection
    end

    game = state
end

local room = makeRoom('bedroom', 2, 2)


function game:enter()
    print(Inspect(game))
    -- print(Inspect(room))
end

function game:update(dt)
end

function game:keypressed(key, code)
end

function game:mousepressed(x, y, mbutton)
end

function game:draw()
    local img = locationFrame(game.location.room,game.location.direction,game.location.x,game.location.y)
    love.graphics.draw(img, 0, 0)
    love.graphics.printf(game.location.room,100, 0, 200,"center")
    print(Inspect(game))
end

return game
