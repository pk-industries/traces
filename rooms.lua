local createRoom = require("lib/createRoom")

rooms = {}

rooms.Bedroom =
    createRoom(
    "bedroom",
    "east",
    {
        "pics/bedroom/navigate/north_door.png",
        "pics/bedroom/navigate/east_bed_nightstand.png",
        "pics/bedroom/navigate/south_closed_dresser.png",
        "pics/bedroom/navigate/west_door.png"
    },
    "You are in a bedroom. There is a bed, a desk, and a dresser."
)

return rooms
