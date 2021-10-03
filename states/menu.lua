menu = {}
local newImage = love.graphics.newImage

function menu:load()
    menu.screen = "start"
end

function menu.update(dt)

end

function menu:draw()
    if menu.screen == "start" then
        local frame = newImage("pics/startScreen.png")
        love.graphics.draw(frame, 0, 0)
    end
end

function menu:keypressed(key, scancode, isrepeat)
    if key == enter_key then
        state.mode = "game"
        if game == nil then
            game:load()
        end

    end
end

return menu
