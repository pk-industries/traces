local loadTimeStart = love.timer.getTime()

require("globals")

-- * state modes are: "menu", "game"
state = {}



function love.load()
    love.window.setIcon(love.image.newImageData(CONFIG.window.icon))
    love.graphics.setDefaultFilter(CONFIG.graphics.filter.down,
                                   CONFIG.graphics.filter.up,
                                   CONFIG.graphics.filter.anisotropy)

    -- Draw is left out so we can override it ourselves
    local callbacks = {'update'}
---@diagnostic disable-next-line: undefined-field
    for k in pairs(love.handlers) do
        -- print(k)
        callbacks[#callbacks+1] = k
    end

    State.registerEvents(callbacks)
    State.switch(States.game)

    if DEBUG then
        local loadTimeEnd = love.timer.getTime()
        local loadTime = (loadTimeEnd - loadTimeStart)
        print(("Loaded game in %.3f seconds."):format(loadTime))
    end


    state.mode = "menu"
    menu:load()
end

function love.update(dt)
    if state.mode == "game" then
        if game then
            game.update(dt)
        end
    else
        game = rooms.bedroom
    end
end

function love.draw()
    if state.mode == "menu" then
        menu.draw()
    elseif state.mode == "game" then
        if not player.mode then
            player.mode = "moving"
        end
        if not player.facing then
            player.facing = "east"
        end
        game:draw()
    end
end

function love.keypressed(key, scancode, isrepeat)
    if state.mode == "menu" then
        menu:keypressed(key, scancode, isrepeat)
    elseif state.mode == "game" then
        game:keypressed(key, scancode, isrepeat)
    end
end
