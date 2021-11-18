require "house.room"

local Radio = require "house.bedroom.radio"
local Closet = require "house.bedroom.closet"
local Hall = require "house.bedroom.hall"
local Bathroom = require "house.bedroom.bathroom"

local Bedroom =
    Room(
    "bedroom",
    {
        x = 1,
        y = 1,
        direction = "e",
        width = 2,
        height = 2,
        description = "You are in a bedroom.",
        children = {
            Radio,
            Bathroom,
            Closet,
            Hall
        }
    }
)

return Bedroom
