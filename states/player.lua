---@class Player
---@field direction "n" | "s" | "e" | "w"
---@field x number
---@field y number
Player = {
    direction = "s",
    x = 2,
    y = 1
}
---@return string string of player coordinates
-- example "x.y.direction" or "1.1.e"

function Player:posStr()
    local direction, x, y = self:getPosition()
    return direction .. "." .. x .. "." .. y
end

function Player:getPosition()
    return self.direction, self.x, self.y
end

Signal.register(
    "player.position-check",
    function()
        if setContains(GameState.current().scenes, Player:posStr()) then
            Player.scene = GameState.current().scenes[Player:posStr()]
        else
            Player.scene = nil
        end
    end
)

function Player:move(key)
    local d, x, y = self:getPosition()
    local w, h = GameState.current().width, GameState.current().height

    -- UP
    if key == Controls.up then
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
    elseif key == Controls.right then
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
    elseif key == Controls.down then
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
    elseif key == Controls.left then
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

    Player.direction = d
    Player.x = x
    Player.y = y

    Signal.emit("player.position-check")
end
