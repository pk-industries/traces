Gfx = love.graphics
StartScreen = {}
StartScreen.entered = true

function StartScreen:load()
    StartScreenMain, Start, Options = Gfx.newImage("pics/startScreen.png"), Gfx.newImage("pics/startScreenStart.png"), Gfx.newImage("pics/startScreenOptions.png")
    StartScreenFrames = {StartScreenMain, Start, Options}
    CurrentWall = StartScreenMain

    function love.keypressed(key)
        if CurrentWall == StartScreenMain then
            if key == "up" or "down" or "left" or "right" or "a" or "b" then
                CurrentWall = Start
            end
        elseif CurrentWall == Start then
            if key == "down" then
                CurrentWall = Options
            elseif key == "a" then
                StartScreen.entered = false
                Bedroom.entered = true
            
                if Bedroom.entered then
                    Bedroom:load()
                end
                
            end
        elseif CurrentWall == Options then
            if key == "up" then 
                CurrentWall = Start
            end
        end
    end

end

function StartScreen:draw()
    Gfx.draw(CurrentWall, 0, 0)
end