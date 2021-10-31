require "globals"

---@type love.load
function love.load()
    love.window.setTitle("traces")
    CONFIG.window.resize(CONFIG.window.scale)
    GameState.registerEvents()
    GameState.switch(States.welcome)
end
---@type love.update
function love.update(dt)
end
---@type love.draw
function love.draw()
    -- canvas:setFilter("nearest", "nearest", 1)
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.graphics.setLineStyle("rough")
    love.graphics.setShader(PlayDateShader)

    GameState.current():draw()
    love.graphics.setShader()
end

---@type love.keypressed
function love.keypressed(key, code)
    if key == "1" then
        CONFIG.window.resize(1)
        local mainmenu = require "utils.menus"
    elseif key == "2" then
        CONFIG.window.resize(2)
    elseif key == "3" then
        CONFIG.window.resize(3)
    end
end
function love.threaderror(thread, errorMessage)
    debugger:errorhandler(errorMessage)
end
---@type love.errorhandler
function love.errorMessage(msg, trace)
    debugger:errorhandler(msg, trace)
end

---@type love.mousemoved
function love.mousemoved(id, x, y, dx, dy, pressure)
    -- print(id, x, y, dx, dy, pressure)
end
