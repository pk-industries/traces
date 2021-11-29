local Scene = require "libs.scene"

local Bathroom =
    Scene(
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
