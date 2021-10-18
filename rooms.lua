require "states.game"
-- this means the room has a grid of 2x2 tiles.
-- Bedroom 2X2
-- ⚀ ---------- ⚁   ⚀ ---------- ⚁
-- |  1      2  |   |  x1,y1     |
-- |            |   |            |
-- |  3      4  |   |            |
-- ⚂ ---------- ⚃   ⚂ ---------- ⚃

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
    init = function(self, wall, x, y)
        self.wall = wall
        self.x = x
        self.y = y
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
    ---@param exits table<RoomName, Exit> | nil
    init = function(self, name, width, height, exits)
        self.name = name
        self.width = width
        self.height = height
        self.exits = exits or {}
    end
}

local Rooms = {
    ["bedroom"] = Room(
        "bedroom",
        2,
        2,
        {
            ["bathroom"] = Exit("n", 2, 2),
            ["closet"] = Exit("s", 1, 1),
            ["hall"] = Exit("w", 1, 2)
        }
    ),
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
    }
}

return Rooms
