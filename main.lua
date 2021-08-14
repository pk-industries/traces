Gfx = love.graphics
--Sets window when running love game to 400x240 pixels.
love.window.setMode(800, 480)

function love.load()

    require "livingRoom"
    if LivingRoom.entered == true then
        LivingRoom:load()
    end
end

function love.draw()
    
end