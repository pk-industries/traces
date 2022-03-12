---@author: snorhax 2022-02-14

local Room = require "libs.room"
local TraceRoom = Class { __includes = Room}

--- Constructor
---@param id string
---@param width number
---@param height number
---@param views table
---@param scenes table
---@param obstacles table 
function TraceRoom:init(id, width, height, views, scenes, obstacles)
    Room.init(self, id)
    self.width = width
    self.height = height
    self.views = views
    self.scenes = scenes
    self.obstacles = obstacles
end

function TraceRoom:enter()
    System.setTitle(GameState.current().id)
end

function TraceRoom:update(dt)
    Timer.update(dt)
end

function TraceRoom:draw()
    local _, err = pcall(
        function() self:render() end
    )
    if err then print(err) end
end

function TraceRoom:keypressed(key)
    local _, err = pcall(function()self.navigate(self, key) end)
    if err then print(err) end
end

function TraceRoom:wheelmoved(x, y)
    if type(self.scene) == "table" then
        self.scene:wheelmoved(x, y)
    end
end

return TraceRoom