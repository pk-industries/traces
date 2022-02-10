local function positionCollision(pos, col)
    return pos.direction == col.direction and pos.x == col.x and pos.y == col.y
end

---@alias RoomId string | "bedroom"
---@alias Direction string | "n" | "s" | "e" | "w"
--  The position of the player in the home
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
    end;

    __tostring = function(self)
        local strs = {
            self.id .. " at (",
            self.x .. ",",
            self.y .. ") facing ",
            self.direction .. " with child ",
            self.child
        }
        return table.concat(strs, "")
    end
}

---@class Room : HomePosition
---@see HomePosition
---@field width number
---@field height number
---@field children table<RoomId, View>
---@field move fun(key:love.Scancode):nil
---@field keypressed fun(key:love.Scancode):nil
---@field update love.update
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
    end;
    
    update = function(self, dt)
    end;
    
    leave = function(self)
    end;
}

function Room:draw()
    local cstate = GameState.current()
    local d, x, y = cstate.direction, cstate.x, cstate.y
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. self.id .. "/"
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename

    if love.filesystem.getInfo(filepath) then
        local img = love.graphics.newImage(filepath)
        local scale = CONFIG.window.scale
        love.graphics.draw(img, 0, 0, 0, scale, scale)
    else
        print("File not found: " .. filepath)
    end
    -- collectgarbage()
end

function Room:keypressed(key)
    local cstate = GameState.current()
    local d, x, y = cstate.direction, cstate.x, cstate.y
    local w, h = cstate.room.width, cstate.room.height

    local nstate = {}

    if d == "n" then
        if key == Controls.up and y + 1 <= h then
            nstate.y = y + 1
        elseif key == Controls.right then
            nstate.direction = "e"
        elseif key == Controls.down and y - 1 >= 1 then
            nstate.y = y - 1
        elseif key == Controls.left then
            nstate.direction = "w"
        end
    elseif d == "e" then
        if key == Controls.up and x + 1 <= w then
            nstate.x = x + 1
        elseif key == Controls.right then
            nstate.direction = "s"
        elseif key == Controls.down and x - 1 >= 1 then
            nstate.x = x - 1
        elseif key == Controls.left then
            nstate.direction = "n"
        end
    elseif d == "s" then
        if key == Controls.up and y - 1 >= 1 then
            nstate.y = y - 1
        elseif key == Controls.right then
            nstate.direction = "w"
        elseif key == Controls.down and y + 1 <= h then
            nstate.y = y + 1
        elseif key == Controls.left then
            nstate.direction = "e"
        end
    elseif d == "w" then
        if key == Controls.up and x - 1 >= 1 then
            nstate.x = x - 1
        elseif key == Controls.right then
            nstate.direction = "n"
        elseif key == Controls.down and x + 1 <= w then
            nstate.x = x + 1
        elseif key == Controls.left then
            nstate.direction = "s"
        end
    -- collectgarbage()
    end
    
    -- only change modified values
    for k, v in pairs(nstate) do
        GameState.current()[k] = v
    end

    self:scanchildren()
end

function Room:scanchildren()
    local newChild = nil

    for _, child in ipairs(GameState.current().room.children) do
        local pos = GameState.current()
        local isFacingChild = pos.direction == child.direction
            and pos.x == child.x
            and pos.y == child.y

        if isFacingChild then
            newChild = child
            break
        end
    end

    GameState.current().child = newChild
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
