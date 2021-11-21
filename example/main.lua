Timer = require "libs.timer"
function love.load()
    -- repeated tweening

    circle = {rad = 10, x = 100, y = 100}
    local grow, shrink, move_down, move_up
    grow = function()
        Timer.tween(1, circle, {rad = 50}, "in-out-quad", shrink)
    end
    shrink = function()
        Timer.tween(2, circle, {rad = 10}, "in-out-quad", grow)
    end

    move_down = function()
        Timer.tween(3, circle, {x = 700, y = 500}, "bounce", move_up)
    end
    move_up = function()
        Timer.tween(5, circle, {x = 200, y = 200}, "out-elastic", move_down)
    end

    grow()
    move_down()
end

function love.update(dt)
    Timer.update(dt)
end

function love.draw()
    love.graphics.circle("fill", circle.x, circle.y, circle.rad)
end
