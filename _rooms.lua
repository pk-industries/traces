local createRoom = require("utils.createRoom")

rooms = {}
local bedroom = {
    name = "bedroom",
    description = "You are in a bedroom. There is a bed and a desk.",
    grid = {
        x = 2,
        y = 2
    },
    --[[
        this means the room has a grid of 2x2 tiles.

        Bedroom 2X2
        ⚀ ---------- ⚁   ⚀ ---------- ⚁
        |  1      2  |   |  x1,y1     |
        |            |   |            |
        |  3      4  |   |            |
        ⚂ ---------- ⚃   ⚂ ---------- ⚃

     ]]
}
rooms.bedroom =
    createRoom(
    "bedroom",
    {
        "assets/images/bedroom/navigate/north_door.png",
        "assets/images/bedroom/navigate/east_bed_nightstand.png",
        "assets/images/bedroom/navigate/south_closed_dresser.png",
        "assets/images/bedroom/navigate/west_door.png"
    },
    {
        ["north"] = "bathroom",
        -- ["east"] = nil,6
        ["south"] = "closet",
        ["west"] = "hall"
    },
    "You are in a bedroom. There is a bed, a desk, and a dresser."
)
return rooms
