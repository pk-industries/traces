Gfx = love.graphics
--Sets window when running love game to 400x240 pixels.
love.window.setMode(800, 480)

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
    --TODO: don't need this if we load above? research this...
    --if Bathroom.entered then
        --Bathroom:draw()
    --end
end