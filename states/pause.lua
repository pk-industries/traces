require("utils.menus")
local pause = {}

-- Called once, and only once, before entering the state the first time. See Gamestate.switch().
function pause:init()
end

-- Called every time when entering the state. See Gamestate.switch().
function pause:enter(previous, ...)
    pausemenu:setDisabled(false)
end
-- Called when leaving a state. See Gamestate.switch() and Gamestate.pop().
function pause:leave()
    pausemenu:setDisabled(true)
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
    love.graphics.setBackgroundColor(Colors.bg)
    local frame = love.graphics.newImage("assets/images/house.png")
    love.graphics.draw(frame, -15, 0)
    love.graphics.draw(love.graphics.newImage("assets/images/traces.png"), pos.x, 10)
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
