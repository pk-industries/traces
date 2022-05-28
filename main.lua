require "globals"

package.cpath = package.cpath .. ";/Users/gw/.vscode/extensions/tangzx.emmylua-0.3.49/debugger/emmy/mac/emmy_core.dylib"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

local shader

function love.load()
    print("") -- Easier readability if newlined at beginning of program.
    Player = require("states.player")()
    WINDOW = require("libs.window")()

    House = require "house.house"
    Fade = require "house.overlays.fade"
    Flashlight = require "house.overlays.flashlight"

    love.window.setTitle("Traces")


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
    love.graphics.setShader()
    GameState.draw()
end

function love.keypressed(key)
    if key == "1" then
        WINDOW:resize(1)
    elseif key == "2" then
        WINDOW:resize(2)
    elseif key == "3" then
        WINDOW:resize(3)
    end
end