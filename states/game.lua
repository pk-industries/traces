local Bedroom = require "house.bedroom.bedroom"
---@class Game:HomePosition
---@field room Room @The room the player is in.
---@field x number @The x position of the player.
local game = {}

-- Called once, and only once, before entering the state the first time. See Gamestate.switch()
function game:init()
    local savedata = table.load("save.lua")
    if savedata then
        for k, v in pairs(savedata) do
            self[k] = v
        end
    else
        self.roomid = "bedroom"
        self.x = 2
        self.y = 2
        self.direction = "e"
        self.child = nil
        table.save(self, "save.lua")
    end

    print("Game state loaded")
end

-- Called every time when entering the state. See Gamestate.switch().
function game:enter()
    self.room = Bedroom
    self.room:scanchildren()
end

function game:leave()
    table.save(self, "save.lua")
end

-- Update the game state. Called every frame.
function game:update(dt)
    self.room.update(dt)
end
-- Triggered when a key is pressed.
function game:keypressed(key)
    table.save({x = self.x, y = self.y, direction = self.direction}, "save.lua")
    if Controls.arrowkeys[key] then -- if the key is [up|down|left|right]
        self.room:keypressed(key)
    end
    if key == Controls.enter and game.child then
        GameState.push(game.child)
    end
end

-- Triggered when a key is released.
function game:keyreleased(key)
end

-- Draw on the screen. Called every frame.
function game:draw()
    if game.room then
        game.room:draw()
    end
end

return game

-- Called when leaving a state. See Gamestate.switch() and Gamestate.pop().
-- function game:leave()
-- end

-- Called if the window gets or loses focus.
-- function game:focus()
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
