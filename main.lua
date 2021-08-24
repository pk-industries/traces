Gfx = love.graphics
--Sets window when running love game to 400x240 pixels.
love.window.setMode(400, 240)

function love.load()

    require "livingRoom"
    require "bathroom"
    require "closetOne"
    
    if LivingRoom.entered then
        LivingRoom:load()
    elseif Bathroom.entered then
        Bathroom:load()
    elseif ClosetOne.entered then
        ClosetOne:load()
    end

end

function love.draw()
    if LivingRoom.entered then
        LivingRoom:draw()
    elseif Bathroom.entered then
        Bathroom:draw()
    elseif ClosetOne.entered then
        ClosetOne:draw()
    end
end