require "utils.debug"
require "globals"

---@type love.load
function love.load()
    love.window.setTitle("traces")

    CONFIG.window.resize(CONFIG.window.scale, CONFIG.window.flags)
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
    local flags = CONFIG.window.flags
    if key == "tab" then
        if CONFIG.window.flags.display == 1 then
            CONFIG.window.flags.display = 2
        elseif CONFIG.window.flags.display == 2 then
            CONFIG.window.flags.display = 1
        end
        CONFIG.window.resize(CONFIG.window.scale, CONFIG.window.flags)
    end
    if key == "1" then
        CONFIG.window.resize(1, flags)
        local mainmenu = require "utils.menus"
    elseif key == "2" then
        CONFIG.window.resize(2, flags)
    elseif key == "3" then
        CONFIG.window.resize(3, flags)
    end
    table.save(CONFIG.window, ".settings.lua")
end

function love.threaderror(thread, errorMessage)
    Debugger:errorhandler(errorMessage)
end

---@type love.errorhandler
function love.errorMessage(msg, trace)
    Debugger:errorhandler(msg, trace)
end
