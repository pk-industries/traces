WINDOW = {
    savefile = "window.lua",
    init = function(self)
        pcall(
            function()
                local save = table.load(love.filesystem.getSaveDirectory() .. "/" .. self.savefile)
                local w, h = love.graphics.getDimensions()
                if type(save) == "table" then
                    if type(save.width) == "number" and type(save.height) == "number" then
                        self.scale = save.scale
                        self.width = save.width

                        self.height = save.height
                        self.flags = save.flags
                    end
                else -- default values
                    self.scale = 1
                    self.width = 400
                    self.height = 240
                end
                self.width = save.scale * w
                self.height = save.scale * h
            end
        )
        self.baseW = love.graphics.getWidth()
        self.baseH = love.graphics.getHeight()
        love.window.setMode(self.width, self.height, {display = 2})
    end
}

function WINDOW.storedValues()
    return {
        scale = WINDOW.scale,
        height = WINDOW.height,
        width = WINDOW.width,
        flags = WINDOW.flags
    }
end

WINDOW.resize = function(newScale)
    WINDOW.scale = newScale
    WINDOW.width = WINDOW.baseW * WINDOW.scale
    WINDOW.height = WINDOW.baseH * WINDOW.scale

    love.window.setMode(WINDOW.width, WINDOW.height, WINDOW.flags)
    WINDOW:printSettings()
end

function WINDOW:save()
    local save = self.storedValues()
    local err = table.save(save, love.filesystem.getSaveDirectory() .. "/" .. WINDOW.savefile)

    if not err then
        print("Saved window settings to " .. love.filesystem.getSaveDirectory() .. "/" .. self.savefile)
    else
        print("Error saving window settings to " .. love.filesystem.getSaveDirectory() .. "/" .. self.savefile)
    end
end

function WINDOW:printSettings()
    print("Window settings: " .. self.width .. ":" .. self.height .. ":" .. self.scale)
end

return WINDOW
