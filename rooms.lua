local createRoom = require("lib/createRoom")

rooms = {}

rooms.bedroom =
    createRoom(
    "bedroom",
    {
        "pics/bedroom/navigate/north_door.png",
        "pics/bedroom/navigate/east_bed_nightstand.png",
        "pics/bedroom/navigate/south_closed_dresser.png",
        "pics/bedroom/navigate/west_door.png"
    },
    {
        ["north"] = "bathroom",
        -- ["east"] = nil,6
        ["south"] = "closet",
        ["west"] = "hall"
    },
    "You are in a bedroom. There is a bed, a desk, and a dresser."
)

rooms.hall =
    createRoom(
    "hall",
    {
        "pics/hall/navigate/north_picture.png",
        "pics/hall/navigate/east_bedroom_door.png",
        "pics/hall/navigate/south_longview.png",
        "pics/hall/navigate/west_livingroom_entrace.png",
    },
    {
        -- ["north"] = nil,6
        ["east"] = "bedroom",
        -- ["south"] = nil,6
        ["west"] = "livingroom"
    },
    "This is a hall"
)

return rooms
