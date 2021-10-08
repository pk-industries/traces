-- this means the room has a grid of 2x2 tiles.
-- Bedroom 2X2
-- ⚀ ---------- ⚁   ⚀ ---------- ⚁
-- |  1      2  |   |  x1,y1     |
-- |            |   |            |
-- |  3      4  |   |            |
-- ⚂ ---------- ⚃   ⚂ ---------- ⚃

local rooms = {
    bedroom = {
        name = "Bedroom",
        width = 2,
        height = 2,
        description = "This is a bedroom"
    },
    hall = {
        name = "hall",
        width = 1,
        height = 2,
        description = "You are in a hall. There is a door to the north."
    },
    livingroom = {
        name = "livingroom",
        width = 3,
        height = 3,
        description = "You are in a living room. There is a couch and a TV."
    }
}

return rooms
