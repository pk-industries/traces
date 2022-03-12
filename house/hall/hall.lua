local TraceRoom = require "house.traceroom"
local bedroom = require "house.hall.bedroom"

local Hall = Class { __includes = TraceRoom }

function Hall:init()
    TraceRoom.init(
        self,
        "hall",
        1,
        2,
        {},
        {
            ["e.1.2"] = bedroom
        },
        {}
    )
end

function Hall:enter()
    System.setTitle("Hall")
end

return Hall
