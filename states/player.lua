local Class = require "libs.class"
local GameState = require "libs.gamestate"
local Saveable = require "libs.saveable"
local Signal = require "libs.signal"

---@class Player : Saveable
---@field direction string | "n" | "s" | "e" | "w"
---@field x number
---@field y number
local Player = Class { __includes = Saveable }
local PlayerSignals = { PlayerMoved = "player.moved" }

function Player:init(id)
    Saveable.init(self, id or "player")
    self.room = "bedroom"
    self.direction = "n"
    self.x = 2
    self.y = 1

    self.playWakeup = true

    self.isDarkOn = false
    self.isFlashUnlocked = true
    self.isFlashOn = false

    Signal.register(
        PlayerSignals.PlayerMoved,
        function()
            local state = GameState.current()
            local str = self:__tostring()
            print("Player moved to:", str)
            if self:isScene(str) then
                GameState.current().scene = state.scenes[str]
            else -- not a scene
                GameState.current().scene = nil
            end
        end
    )

    -- You can set values to inject/override like shown below. However, a save file will override these values.
    -- self.bedroom = {
    --     ["isLocked"] = false
    -- }
    -- self.hall = {
    --     ["isLocked"] = false
    -- }

    -- Unlock doors
    for _, room in ipairs({ "bedroom", "hall", "closet" }) do
        self[room] = { isLocked = false }
    end

end

function Player:__tostring()
    return self.direction .. "." .. self.x .. "." .. self.y
end

---@return string String of Player coordinates
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
    Signal.emit(PlayerSignals.PlayerMoved)
end

return Player
