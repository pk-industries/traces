require "globals"

package.cpath = package.cpath .. ";/Users/gw/.vscode/extensions/tangzx.emmylua-0.3.49/debugger/emmy/mac/emmy_core.dylib"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

local shader

function love.load()
    print("") -- Easier readability if newlined at beginning of program.
    local class = require "states.player"
    local ok, data = pcall(class, "player")
    if not ok then print("Player could not be created: ", data) end
    Player = data

    House = require "house.house"

    love.window.setTitle("Traces")

    class = require "libs.window"
    ok, data = pcall(class)
    if not ok then print("Window could not be created: ", data) end
    WINDOW = data

    shader = love.graphics.newShader("assets/PlayDateShader.fs")
    GameState.registerEvents()
    GameState.switch(require "states.start")
end

function love.update(dt)
    Timer.update(dt)
end

function love.quit()
    if WINDOW ~= nil then WINDOW:save() end
    if Player ~= nil then Player:save() end
end

function love:draw()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.graphics.setLineStyle("rough")
    love.graphics.setShader(shader)
    love.graphics.setShader()
    GameState.draw()
end

function love.keypressed(key, code)
    if key == "1" then
        WINDOW:resize(1)
    elseif key == "2" then
        WINDOW:resize(2)
    elseif key == "3" then
        WINDOW:resize(3)
    end
end