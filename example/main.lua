Timer = require "libs.timer"
GameState = require "libs.venus"
game = require "game"
function love.load()
    -- repeated tweening
    GameState.registerEvents()
end

function love.update(dt)
end

function love.draw()
    love.graphics.print("hello", 0, 0)
end

function love.keypressed(key)
    GameState.switch(game, "fade", 10)
end
