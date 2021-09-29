-- Attaches console to vscode debugger while running the game
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- * state modes are: "menu", "game"
state = {}

rooms = require("rooms")
menu = require("menu")
game = {}
player = {}


up_key = "up"
right_key = "right"
down_key = "down"
left_key = "left"
enter_key = "return"

function love.load()
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
