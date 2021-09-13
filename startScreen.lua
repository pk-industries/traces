StartScreen = {}
StartScreen.entered = true

function StartScreen:load()
    StartScreenMain, Start, Options = Gfx.newImage("pics/startScreen.png"), Gfx.newImage("pics/startScreenStart.png"), Gfx.newImage("pics/startScreenOptions.png")
    CurrentFrame = StartScreenMain

    function love.keypressed(key)
        if CurrentFrame == StartScreenMain then
            if key == "up" or "down" or "left" or "right" or "a" or "b" then
                CurrentFrame = Start
            end
        elseif CurrentFrame == Start then
            if key == "down" then
                CurrentFrame = Options
            elseif key == "a" then
                Bedroom.entered = true
                StartScreen.entered = false
                if Bedroom.entered then
                    Bedroom:load()
                end
            end
        elseif CurrentFrame == Options then
            if key == "up" then 
                CurrentFrame = Start
            end
        end
    end

end

function StartScreen:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end