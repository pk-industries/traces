local menu = {} -- previously: Gamestate.new()
local newImage = love.graphics.newImage

function menu:draw()
    local bg = newImage("assets/images/startScreen.png")
    love.graphics.draw(bg, 0, 0)
    love.graphics.print("Press Enter to continue", 5, 5)
end

function menu:keyreleased(key, code)
    if key == Controls.enter then
        State.switch(States.game)
    end
end

return menu



--[[ menu = {}
local newImage = love.graphics.newImage

function menu:load()
    menu.screen = "start"
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
