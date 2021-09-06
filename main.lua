--[NEXT SESH?
--TODO: Text box?
--TODO: Music Box
--TODO: General first time door opening animation
--]

Gfx = love.graphics
--Sets window when running love game to 400x240 pixels.
love.window.setMode(400, 240)

function love.load()

    require "startScreen"
    require "livingRoom"
    require "bathroom"
    require "closetOne"
    require "bedroom"
    require "hallway"
    require "musicBox"

    if StartScreen.entered then
        StartScreen:load()
    elseif MusicBox.entered then
        MusicBox:load()
    elseif LivingRoom.entered then
        LivingRoom:load()
    elseif Bathroom.entered then
        Bathroom:load()
    elseif ClosetOne.entered then
        ClosetOne:load()
    elseif Bedroom.entered then
        Bedroom:load()
    elseif Hallway.entered then
        Hallway:load()
    end

end

function love.draw()

    if StartScreen.entered then
        StartScreen:draw()
    elseif MusicBox.entered then
        MusicBox:draw()
    elseif LivingRoom.entered then
        LivingRoom:draw()
    elseif Bathroom.entered then
        Bathroom:draw()
    elseif ClosetOne.entered then
        ClosetOne:draw()
    elseif Bedroom.entered then
        Bedroom:draw()
    elseif Hallway.entered then
        Hallway:draw()
    end
end