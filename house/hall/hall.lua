local TraceRoom = require "house.traceroom"

local Hall =
    Class {
    __includes = TraceRoom
}

function Hall:init()
    TraceRoom.init(self, "hall", 1, 2, {}, {}, {})
end

function Hall:enter()
    System.setTitle("Hall")
end

return Hall
