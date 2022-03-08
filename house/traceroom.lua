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

function TraceRoom:enter()
    love.window.setTitle(GameState.current().id)
end

function TraceRoom:update(dt)
    Timer.update(dt)
end

function TraceRoom:draw()
    local _, err = pcall(self.render(self))
    if err then print(err) end
end

function TraceRoom:keypressed(key)
    local _, err = pcall(self.navigate(self, key))
    if err then print(err) end
end

return TraceRoom