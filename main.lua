Gfx = love.graphics
--Sets window when running love game to 400x240 pixels.
love.window.setMode(400, 240)

function love.load()

    --require "DarkScreen"

    MainWall1, MainWall2, MainWall3, MainWall4 = Gfx.newImage("pics/mainWall1.png"), Gfx.newImage("pics/mainWall2.png"), Gfx.newImage("pics/mainWall3.png"), Gfx.newImage("pics/mainWall4.png")

    MainWalls = {MainWall1, MainWall2, MainWall3, MainWall4}

    CurrentWall = MainWall1

end

function love.keypressed(key)
    if CurrentWall == MainWall1 then
        if key == "right" then
            CurrentWall = MainWall2
        elseif key == "left" then
            CurrentWall = MainWall4
        end
    elseif CurrentWall == MainWall2 then
        if key == "right" then
            CurrentWall = MainWall3
        elseif key == "left" then
            CurrentWall = MainWall1
        end
    elseif CurrentWall == MainWall3 then
        if key == "right" then
            CurrentWall = MainWall4
        elseif key == "left" then
            CurrentWall = MainWall2
        end
    elseif CurrentWall == MainWall4 then
        if key == "right" then
            CurrentWall = MainWall1
        elseif key == "left" then
            CurrentWall = MainWall3
        end
    end
end

function love.draw()
    Gfx.draw(CurrentWall, 0, 0)
end