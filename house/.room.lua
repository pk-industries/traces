---@alias RoomId string | "bedroom"
---@alias Direction "n" | "s" | "e" | "w"

-- The position of the player in the home
---@class HomePosition
---@field id string | "bedroom" | "hall"
---@field x number x-axis position
---@field y number y-axis position
---@field direction Direction
HomePosition =
    Class {
    init = function(self)
        local save, error = table.load("save.lua")
        if save then
            for k, v in pairs(save) do
                self[k] = v
            end
        else
            self.id = "bedroom"
            self.x = 2
            self.y = 1
            self.direction = "n"
            self.child = nil
            print(error)
        end
    end
}

---@class Room : HomePosition
---@see HomePosition
---@field width number
---@field height number
---@field children table<RoomId, View>
---@field move fun(key:love.Scancode):nil
---@field keypressed fun(key:love.Scancode):nil
---@field update function
Room =
    Class {
    __includes = HomePosition,
    init = function(self, id, tbl)
        self.id = id
        if type(tbl) == "table" then
            for k, v in pairs(tbl) do
                self[k] = v
            end
        end
    end,
    update = function(self, dt)
    end,
    leave = function(self)
    end
}

function Room:draw()
    local cstate = GameState.current()
    local d, x, y = cstate.direction, cstate.x, cstate.y
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. self.id .. "/" --- /assets/images/bedroom/
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename

    if love.filesystem.getInfo(filepath) then
        local img = love.graphics.newImage(filepath)
        local scale = CONFIG.window.scale
        love.graphics.draw(img, 0, 0, 0, scale, scale)
    else
        print("File not found: " .. filepath)
    end
end

function Room:keypressed(key)
    local cstate = GameState.current()
    local d, x, y = cstate.direction, cstate.x, cstate.y
    local w, h = cstate.room.width, cstate.room.height

    local nstate = {}

    if d == "n" then
        if key == GamePad.up and y + 1 <= h then
            nstate.y = y + 1
        elseif key == GamePad.right then
            nstate.direction = "e"
        elseif key == GamePad.down and y - 1 >= 1 then
            nstate.y = y - 1
        elseif key == GamePad.left then
            nstate.direction = "w"
        end
    elseif d == "e" then
        if key == GamePad.up and x + 1 <= w then
            nstate.x = x + 1
        elseif key == GamePad.right then
            nstate.direction = "s"
        elseif key == GamePad.down and x - 1 >= 1 then
            nstate.x = x - 1
        elseif key == GamePad.left then
            nstate.direction = "n"
        end
    elseif d == "s" then
        if key == GamePad.up and y - 1 >= 1 then
            nstate.y = y - 1
        elseif key == GamePad.right then
            nstate.direction = "w"
        elseif key == GamePad.down and y + 1 <= h then
            nstate.y = y + 1
        elseif key == GamePad.left then
            nstate.direction = "e"
        end
    elseif d == "w" then
        if key == GamePad.up and x - 1 >= 1 then
            nstate.x = x - 1
        elseif key == GamePad.right then
            nstate.direction = "n"
        elseif key == GamePad.down and x + 1 <= w then
            nstate.x = x + 1
        elseif key == GamePad.left then
            nstate.direction = "s"
        end
    --
    end

    -- only change modified values
    for k, v in pairs(nstate) do
        GameState.current()[k] = v
    end

    self:scanchildren()
end

function Room:scanchildren()
    for i, v in ipairs(GameState.current().room.children) do
        local pos = GameState.current()
        local ischild = pos.direction == v.direction and pos.x == v.x and pos.y == v.y

        if ischild then
            GameState.current().child = v
            print("Child: " .. v.id)
            return
        end
    end
    GameState.current().child = nil
end

---@class View : HomePosition
---@field id RoomId
---@field init fun(self:View, id:RoomId, d:Direction)
Child =
    Class {
    ---@param id RoomId
    ---@param x number
    ---@param tbl table<string,any>
    init = function(self, id, d, x, y, tbl)
        self.id = id
        self.direction = d
        self.x = x
        self.y = y
        if type(tbl) == "table" then
            for k, v in pairs(tbl) do
                self[k] = v
            end
        end
    end
}

return Room, Child
