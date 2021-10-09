local pause = {}

local pausemenu = MenuEngine.new(10, 20, Fonts.pixel[20])
pausemenu:addEntry(
    "Start Game",
    function()
        State.switch(States.game)
    end
)
pausemenu:addSep()
pausemenu:addEntry(
    "Quit Game",
    function()
        pause.quit()
    end
)
-- Called once, and only once, before entering the state the first time. See Gamestate.switch().
function pause:init(self)
end

-- Called every time when entering the state. See Gamestate.switch().
function pause:enter(previous, ...)
end
-- Called when leaving a state. See Gamestate.switch() and Gamestate.pop().
function pause:leave()
end

-- Called when re-entering a state by Gamestate.pop()-ing another state.
function pause:resume()
end

-- Update the game state. Called every frame.
function pause:update()
    pausemenu:update()
end

-- Draw on the screen. Called every frame.
function pause:draw()
    local bg = love.graphics.newImage("assets/images/pause.png")
    love.graphics.draw(bg, 0, 0)
    pausemenu:draw()
end

-- Called if the window gets or loses focus.
function pause:focus()
end

-- Triggered when a key is pressed.
function pause:keypressed(key, scancode)
    MenuEngine.keypressed(scancode)
end

-- Triggered when a key is released.
function pause:keyreleased()
end

-- Called on quitting the game. Only called on the active gamestate.
function pause:quit()
    love.event.quit()
end

return pause
