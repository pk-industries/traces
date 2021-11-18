require "house.room"

local Bathroom =
    Child(
    "bathroom",
    "n",
    2,
    2,
    {
        type = "door",
        locked = true
    }
)

return Bathroom
