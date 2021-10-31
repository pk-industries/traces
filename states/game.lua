local GameObject = require "libs.gameobject"

---@class game : GameObject

local game = GameObject("bedroom", "n", 1, 2)

-- Called once, and only once, before entering the state the first time. See Gamestate.switch().
function game:init()
    print(Inspect(game))
end

-- Called every time when entering the state. See Gamestate.switch().
function game:enter(previous, ...)
    canvas = love.graphics.newCanvas(love.graphics.getWidth(), 600)

    -- Rectangle is drawn to the canvas with the regular alpha blend mode.
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(1, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, 100, 100)
    love.graphics.setCanvas()
end

-- Update the game state. Called every frame.
function game:update()
end
-- Triggered when a key is pressed.
function game:keypressed(key)
    if Controls.arrowkeys[key] then -- if the key is [up|down|left|right]
        self:move(key)
        self.exit = self:isexit()
        self.view = self:isview()
        game.bgimg = self:getbgimg()
    end
    if game.view and key == Controls.enter then
        print(game.bgimg)
        GameState.switch(game.view)
    end
end

-- Draw on the screen. Called every frame.
function game:draw()
    local bgimg = love.graphics.newImage(game.bgimg)
    love.graphics.draw(bgimg, 0, 0, 0, CONFIG.window.scale, CONFIG.window.scale)
end

return game

-- Called when leaving a state. See Gamestate.switch() and Gamestate.pop().
-- function game:leave()
-- end

-- Called if the window gets or loses focus.
-- function game:focus()
-- end

-- Triggered when a key is released.
-- function game:keyreleased()
-- end

-- Triggered when a mouse button is pressed.
-- function game:mousepressed()
-- end

-- Triggered when a mouse button is released.
-- function game:mousereleased()
-- end

-- Triggered when a joystick button is pressed.
-- function game:joystickpressed()
-- end

-- Triggered when a joystick button is released.
-- function game:joystickreleased()
-- end

-- Called on quitting the game. Only called on the active gamestate.
