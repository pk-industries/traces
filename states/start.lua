local welcome = {} -- previously: Gamestate.new()
local newImage = love.graphics.newImage

local music = love.audio.newSource("assets/sounds/noisey-static.mp3", "stream")

function welcome:enter()
    music:setLooping(true)
    music:setVolume(0.1)
    music:play()
end

function welcome:leave()
    music:stop()
end

function welcome:draw()
    local bg = newImage("assets/images/startScreen.png")
    love.graphics.draw(bg, 0, 0)
    love.graphics.print("Press Enter to continue", 5, 5)
end

function welcome:keyreleased(key, code)
    if key == Controls.enter then
        GameState.switch(States.game)
    end
end

return welcome

--[[ welcome = {}
local newImage = love.graphics.newImage

function welcome:load()
    welcome.screen = "start"
end

function menu.update(dt)

end

function menu:draw()
    if menu.screen == "start" then
        local frame = newImage("assets/images/startScreen.png")
        love.graphics.draw(frame, 0, 0)
    end
end

function menu:keypressed(key, scancode, isrepeat)
    if key == Controls.enter then
        state.mode = "game"
        if game == nil then
            game:load()
        end

    end
end

return menu ]]
