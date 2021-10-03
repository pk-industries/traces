local createRoom = require("utils.createRoom")

rooms = {}

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

rooms.hall =
    createRoom(
    "hall",
    {
        "assets/images/hall/navigate/north_picture.png",
        "assets/images/hall/navigate/east_bedroom_door.png",
        "assets/images/hall/navigate/south_longview.png",
        "assets/images/hall/navigate/west_livingroom_entrace.png",
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
