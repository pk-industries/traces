require "globals"
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

function love.load()
    GameState.registerEvents()
    GameState.switch(States.welcome)
end

function love.update(dt)
end

function love.draw()
    GameState.current():draw()
end

function love.keypressed(key, code)
end

function love.threaderror(thread, errorMessage)
    print("Thread error!\n" .. errorMessage)
end

function love.errorhandler(msg)
end
