require "libs.tablesave"
local Saveable = require "libs.saveable"

local WINDOW = Class {
    __includes = Saveable,
    init = function(self)
        Saveable.init(self, "window")
        self.scale = 1
        self.width = 400
        self.height = 240
        self.baseW = love.graphics.getWidth()
        self.baseH = love.graphics.getHeight()
        local ok, err = pcall(self.load, self)
        if not ok then print(err) end
        love.window.setMode(self.width, self.height, {display = 2})
    end,
    __tostring = function(self)
        for k, v in pairs(self:storedValues()) do
            print(k .. ":", v)
        end
    end
}

function WINDOW:storedValues()
    return {
        scale = self.scale,
        height = self.height,
        width = self.width,
        flags = self.flags
    }
end

function WINDOW:resize(newScale)
    self.scale = newScale
    self.width = self.baseW * self.scale
    self.height = self.baseH * self.scale

    love.window.setMode(self.width, self.height, self.flags)
    print(self:__tostring())
end

return WINDOW
