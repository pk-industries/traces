local Scene = require "libs.scene"

local Closet =
    Scene(
    "closet",
    "s",
    1,
    1,
    {
        type = "door",
        locked = true
    }
)

return Closet
