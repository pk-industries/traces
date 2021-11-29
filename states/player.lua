---@class player
---@field direction "n" | "s" | "e" | "w"
---@field x number
---@field y number

local player =
    Class {
    __includes = Saveable,
    id = "player",
    room = "bedroom",
    direction = "n",
    x = 1,
    y = 1
}

function player:init(id)
    Saveable.init(self, self.id)
    Saveable.load(self)
end
function player:__tostring()
    return self.direction .. "." .. self.x .. "." .. self.y
end

---@return string string of player coordinates
-- example "x.y.direction" or "1.1.e"
function player:getPosition()
    return self.direction, self.x, self.y
end

Signal.register(
    "player.position-check",
    function()
        if setContains(GameState.current().scenes, player:__tostring(player)) then
            player.scene = GameState.current().scenes[player:__tostring(player)]
        else
            player.scene = nil
        end
    end
)

function player:move(key)
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

    player.direction = d
    player.x = x
    player.y = y

    Signal.emit("player.position-check")
end

return player
