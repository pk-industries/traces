Gfx = love.graphics
FRAME = false
LOCATION = "menu"
Menus = {}

Menus.Start = {frame = love.graphics.newImage("pics/startScreen.png")}



function love.load()
    LOCATION = "menu"
    -- FRAME = Menus.Start.frame
end

function love.update(dt)
    -- Gfx.draw(state.rooms.StartScreen, 0, 0)
    function love:keypressed(key)
        love.window.setTitle("L: " ..tostring(LOCATION))
    end


    if LOCATION == "menu" then
        FRAME = Menus.Start.frame
        function love:keypressed(key)
            love.window.setTitle("L: " ..tostring(key))
        end
    end
end

function love.draw(dt)
    Gfx.draw(FRAME, 0, 0)
end
