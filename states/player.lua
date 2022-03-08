local Class = require "libs.class"
local GameState = require "libs.gamestate"
local Saveable = require "libs.saveable"
local Signal = require "libs.signal"

---@class Player : Saveable
---@field direction string | "n" | "s" | "e" | "w"
---@field x number
---@field y number
---@field load fun() Loads player data
local Player = Class {__includes = Saveable}

function Player:init(id)
    Saveable.init(self, id or "player")
    ---@alias Player.room string
    self.room = "hall"
    ---@alias Player.direction string
    self.direction = "n"
    ---@alias Player.x number
    self.x = 1
    ---@alias Player.y number
    self.y = 1
end

function Player:__tostring()
    return self.direction .. "." .. self.x .. "." .. self.y
end

---@return string String of Player coordinates
-- example "x.y.direction" or "1.1.e"
function Player:getPosition()
    return self.direction, self.x, self.y
end

--- Set player position.
---@param d Player.direction
---@param x Player.x
---@param y Player.y
---@return number d,number x,number y - Direction, X, Y
function Player:setPosition(d, x, y)
    self.direction = d
    self.x = x
    self.y = y
    return d, x, y
end

function Player:isScene(str)
    local state = GameState.current()
    if type(state) == "table" and setContains(state, "scenes") then
        if setContains(state.scenes, str) then
            return true
        end
    end
    return false
end

Signal.register(
    "player.moved",
    function()
        local state = GameState.current()
        local str = Player:__tostring()
        GameState.current().info.str = str
        print("Player moved to:", str)
        if Player:isScene(str) then
            GameState.current().scene = state.scenes[str]
        else -- not a scene
            GameState.current().scene = nil
        end
    end
)

function Player:move(key)
    local d, x, y = self:getPosition()
    local w, h = GameState.current().width, GameState.current().height

    -- UP
    if key == GamePad.up then
        -- RIGHT
        if d == "n" and y + 1 <= h then
            y = y + 1
        elseif d == "e" and x + 1 <= w then
            x = x + 1
        elseif d == "s" and y - 1 >= 1 then
            y = y - 1
        elseif d == "w" and x - 1 >= 1 then
            x = x - 1
        end
    elseif key == GamePad.right then
        -- DOWN
        if d == "n" then
            d = "e"
        elseif d == "e" then
            d = "s"
        elseif d == "s" then
            d = "w"
        elseif d == "w" then
            d = "n"
        end
    elseif key == GamePad.down then
        -- LEFT
        if d == "n" and y - 1 >= 1 then
            y = y - 1
        elseif d == "e" and x - 1 >= 1 then
            x = x - 1
        elseif d == "s" and y + 1 <= h then
            y = y + 1
        elseif d == "w" and x + 1 <= w then
            x = x + 1
        end
    elseif key == GamePad.left then
        if d == "n" then
            d = "w"
        elseif d == "e" then
            d = "n"
        elseif d == "s" then
            d = "e"
        elseif d == "w" then
            d = "s"
        end
    end

    self.direction, self.x, self.y = d, x, y
    Signal.emit("player.moved")
end

return Player

--[[ Signal.register(
    "player.position-check",
    function(direction, x, y)
        local key = Player:__tostring()
        local scenes = GameState.current().scenes

        if setContains(scenes, key) then
            love.window.setTitle(key)
            if type(scenes[key]) == "table" then
                Player.scene = scenes[key]
                Signal.emit("scene.enter")
            else
                Player.scene = House[key]
            end
        else
            GameState.current().scene = nil
            love.window.setTitle(GameState.current().id)
        end
    end
) ]]
--[[ Signal.register(
    "scene.enter",
    function()
        local scene = Player.scene
        -- print("scene.enter", scene.id)
        print(Inspect(scene))
        -- GameState.push(scene)
    end
)
 ]]
