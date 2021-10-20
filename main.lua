require "globals"
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

function love.load()
    GameState.registerEvents()
    GameState.switch(States.welcome)
end
require("libs.lovebird").update()

function love.update(dt)
end

function love.draw()
    -- local drawTimeStart = love.timer.getTime()
    GameState.current():draw()
    -- local drawTimeEnd = love.timer.getTime()
    -- local drawTime = drawTimeEnd - drawTimeStart
end

function love.keypressed(key, code)
end

function love.threaderror(thread, errorMessage)
    print("Thread error!\n" .. errorMessage)
end

function love.errorhandler(msg)
end
