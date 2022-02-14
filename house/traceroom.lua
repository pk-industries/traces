---@author: snorhax 2022-02-14

local TraceRoom = Class { __includes = Room,
    init = function (self, id, width, height, views, scenes, obstacles)
        Room.init(self, id)
        self.width = width
        self.height = height
        self.views = views
        self.scenes = scenes
        self.obstacles = obstacles
    end
}

TraceRoom:include(Room)

function TraceRoom:enter()
    love.window.setTitle(GameState.current().id)
end

function TraceRoom:update(dt)
    Timer.update(dt)
end

function TraceRoom:draw()
    pcall(function ()
        self.render(self)
    end)
end

function TraceRoom:keypressed(key)
    pcall(
        function ()
            self.navigate(self, key)
        end,
        function (err)
            print(err)
        end
    )
end

return TraceRoom