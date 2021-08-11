gfx = love.graphics

function love.load()

  mainWall1, mainWall2, mainWall3, mainWall4 = gfx.newImage("pics/mainWall1.png"), gfx.newImage("pics/mainWall2.png"), gfx.newImage("pics/mainWall3.png"), gfx.newImage("pics/mainWall4.png")

  mainWalls = {mainWall1, mainWall2, mainWall3, mainWall4}

  currentWall = mainWall1

end

function love.keypressed(key)
    if currentWall == mainWall1 then
        if key == "right" then
            currentWall = mainWall2
        elseif key == "left" then
            currentWall = mainWall4
        end
    elseif currentWall == mainWall2 then
        if key == "right" then
            currentWall = mainWall3
        elseif key == "left" then
            currentWall = mainWall1
        end
    elseif currentWall == mainWall3 then
        if key == "right" then
            currentWall = mainWall4
        elseif key == "left" then
            currentWall = mainWall2
        end
    elseif currentWall == mainWall4 then
        if key == "right" then
            currentWall = mainWall1
        elseif key == "left" then
            currentWall = mainWall3
        end
    end
end

function love.draw()
    gfx.draw(currentWall, 0, 0)
end