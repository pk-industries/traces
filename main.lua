--[NEXT SESH?
--TODO: Text box: See text.lua for current state of functionality
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
    require "text"

    if StartScreen.entered then
        StartScreen:load()
    elseif MusicBox.entered then
        TextBox:load()
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

    --TextBox needs to be a lone conditional bc it will be drawn on the screen with other things
    if TextBox.entered then
        TextBox:load()
    end

end

function love.update()
    if TextBox.entered then
        TextBox:update()
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

    --TextBox needs to be a lone conditional bc it will be drawn on the screen with other things
    --Needs to be drawn after everything else since it's on top of everything on the screen
    if TextBox.entered then
        TextBox:draw()
    end
    
end