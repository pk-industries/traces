require "globals"

function love.load()
    love.window.setTitle("traces")
    CONFIG.window.resize(CONFIG.window.scale)
    GameState.registerEvents()
    GameState.switch(States.welcome)
end

function love.update(dt)
end

function love.draw()
    -- canvas:setFilter("nearest", "nearest", 1)
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.graphics.setLineStyle("rough")
    love.graphics.setShader(PlayDateShader)

    GameState.current():draw()
    love.graphics.setShader()
end

function love.keypressed(key, code)
    if key == "1" then
        CONFIG.window.resize(1)
    elseif key == "2" then
        CONFIG.window.resize(2)
    elseif key == "3" then
        CONFIG.window.resize(3)
    end
end

function love.threaderror(thread, errorMessage)
    debugger:errorhandler(errorMessage)
end

function love.errorMessage(msg, trace)
    debugger:errorhandler(msg, trace)
end
