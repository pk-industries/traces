---@alias Direction "e"|"n"|"s"|"w"
---@alias RoomName "bedroom"|"bathroom"|"kitchen"|"livingroom"

---@class Exit
---@field wall Direction
---@field x number
---@field y number
local Exit =
    Class {
    ---@param wall Direction
    ---@param x number
    ---@param y number
    init = function(self, direction, x, y)
        self.direction = direction
        self.x = x
        self.y = y
        self.locked = true
    end
}
---@class View : Exit
local View =
    Class {
    __includes = Exit,
    draw = function(self)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", self.x, self.y, 32, 32)
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("line", self.x, self.y, 32, 32)
    end
}

---@class Room
---@field name string
---@field width number
---@field height number
---@field exits table<RoomName, Exit>
---@return Room
local Room =
    Class {
    ---@param self Room
    ---@param name string
    ---@param width number
    ---@param height number
    ---@param exits table<RoomName, View> | nil
    ---@param views table<RoomName, Exit> | nil
    init = function(self, name, width, height, exits, views)
        self.name = name
        self.width = width
        self.height = height
        self.exits = exits or {}
        self.views = views or {}
    end
}
Radio = View("e", 2, 2)

local bedroom =
    Room(
    "bedroom",
    2,
    2,
    {
        bathroom = Exit("n", 2, 2),
        closet = Exit("s", 1, 1),
        hall = Exit("w", 1, 2)
    },
    {
        radio = Radio
    }
)
bedroom.views.bedroom = Radio

function Radio:enter()
    print("Radio:enter")
end

local Rooms = {
    bedroom = bedroom,
    hall = {
        name = "hall",
        width = 1,
        height = 2,
        description = "You are in a hall. There is a door to the north.",
        {
            ["bedroom"] = Exit("w", 1, 2),
            ["closet"] = Exit("s", 1, 1),
            ["hall"] = Exit("w", 1, 2)
        }
    },
    livingroom = {
        name = "livingroom",
        width = 3,
        height = 3,
        description = "You are in a living room. There is a couch and a TV."
    },
    ---@param name RoomName
    getRoom = function(self, name)
        return self[name]
    end,
    getRoomExits = function(self, name)
        return self[name].exits
    end,
    getRoomViews = function(self, name)
        return self[name].views
    end,
    getRoomSize = function(self, name)
        local room = self[name]
        return room.width, room.height
    end
}

Room =
    Class {
    init = function(self, tbl)
        for k, v in pairs(tbl) do
            self[k] = v
        end
    end
}

function Room:move(key)
    if self.direction == "n" then
        if key == Controls.up and self.y + 1 <= self.height then
            self.y = self.y + 1
        elseif key == Controls.right then
            self.direction = "e"
        elseif key == Controls.down and self.y - 1 >= 1 then
            self.y = self.y - 1
        elseif key == Controls.left then
            self.direction = "w"
        end
    elseif self.direction == "e" then
        if key == Controls.up and self.x + 1 <= self.width then --
            self.x = self.x + 1
        elseif key == Controls.right then
            self.direction = "s"
        elseif key == Controls.down and self.x - 1 >= 1 then
            self.x = self.x - 1
        elseif key == Controls.left then
            self.direction = "n"
        end
    elseif self.direction == "s" then
        if key == Controls.up and self.y - 1 >= 1 then
            self.y = self.y - 1
        elseif key == Controls.right then
            self.direction = "w"
        elseif key == Controls.down and self.y + 1 <= self.height then
            self.y = self.y + 1
        elseif key == Controls.left then
            self.direction = "e"
        end
    elseif self.direction == "w" then
        if key == Controls.up and self.x - 1 >= 1 then
            self.x = self.x - 1
        elseif key == Controls.right then
            self.direction = "n"
        elseif key == Controls.down and self.x + 1 <= self.width then
            self.x = self.x + 1
        elseif key == Controls.left then
            self.direction = "s"
        end
    end
    -- self.exit = self:isexit()
    -- self.view = self:isview()
    -- self.bgimg = self:getbgimg()
    print("{  " .. self.direction .. ", " .. self.x .. " , " .. self.y .. ", " .. " }")
end

Bedroom = {
    name = "bedroom",
    width = 2,
    height = 2,
    description = "You are in a bedroom.",
    exits = {
        bathroom = Exit("n", 2, 2),
        closet = Exit("s", 1, 1),
        hall = Exit("w", 1, 2)
    },
    views = {
        radio = Radio
    }
}

return Rooms
