local TraceRoom = require "house.traceroom"

local Hall =
    Class { __includes = TraceRoom,
    init = function(self)
        TraceRoom.init(self, "hall", 1, 2, {}, {}, {})
    end
}

return Hall