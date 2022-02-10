local Hall = {id = "hall"}
function Hall:enter()
    print("Hello World!")
end

function Hall:update(dt)
end

function Hall:draw()
    love.graphics.setBackgroundColor(255, 0, 0)
    love.graphics.print("example", 0, 0)
end

return Hall
