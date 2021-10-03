

require 'globals'
local debugger = require 'utils.debug'

function love.load()
    local callbacks = debugger:load()
    State.registerEvents(callbacks)
    State.switch(States.menu)
end

function love.update(dt)
end

function love.draw()
    local drawTimeStart = love.timer.getTime()
    State.current():draw()
    local drawTimeEnd = love.timer.getTime()
    local drawTime = drawTimeEnd - drawTimeStart

    debugger:draw(drawTimeStart, drawTimeEnd, drawTime)
end

function love.keypressed(key, code, isRepeat)
  debugger:keypressed(key, code, isRepeat)
end

function love.threaderror(thread, errorMessage)
    print('Thread error!\n' .. errorMessage)
end

function love.errorhandler(msg)
   debugger:errorhandler(msg)
end
