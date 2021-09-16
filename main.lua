--[NEXT SESH?
--TODO: Text box: incrementer for amount of times entered room
--TODO: Music Box
--TODO: State machine instead of .entered for each room/puzzle/etc?
--TODO: Hard code numbers in for each animation, per Sheepolution's animation section
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
    require "closetTwo"

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
    elseif ClosetTwo.entered then
        ClosetTwo:load()
    end

    --TextBox needs to be a lone conditional bc it will be drawn on the screen with other things
    if TextBox.entered then
        TextBox:load()
    end

end

function love.update(dt)

    --Had to switch over key pressed handlers to the update() function,
    --because I found that the textbox would pop up, then I would control room changing stuff with
    --the textbox still up.

    --TODO: Figure out WHY my conditionals have to be structured this way for textbox logic to work -_-
    if MusicBox.entered then
        MusicBox:update()
    elseif Bedroom.entered then
        Bedroom:update(dt)
    elseif Bathroom.entered then
        Bathroom:update()
    elseif ClosetOne.entered then
        ClosetOne:update()
    elseif ClosetTwo.entered then
        ClosetTwo:update()
    end

    if ClosetOne.entered then
        ClosetOne:update()
    end

    if Bathroom.entered then
        Bathroom:update()
    end

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
    elseif ClosetTwo.entered then
        ClosetTwo:draw()
    end

    --Passes the correct text based on whatcha want as an argument to text.lua's TextBox:draw()
    if TextBox.entered and MusicBox.entered then
        TextBox:draw(TextBox.musicBoxText)
    elseif TextBox.entered and Bathroom.entered then
        TextBox:draw(TextBox.bathroomText)
    end
    
end