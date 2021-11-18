require "house.room"

local Hall =
    Child(
    "hall",
    "w",
    1,
    2,
    {
        type = "door",
        locked = true
    }
)

return Hall
