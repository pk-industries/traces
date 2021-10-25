require "globals"

function love.load()
    love.window.setTitle("traces")
    CONFIG.window.resize(1)
    GameState.registerEvents()
    GameState.switch(States.welcome)
end

function love.update(dt)
end

function love.draw()
    GameState.current():draw()
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
    print("Thread error!\n" .. errorMessage)
end
