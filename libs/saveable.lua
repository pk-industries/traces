require "libs.tablesave"

---@class Saveable
---@field saveFile string the name of the file that this instance saves and loads to
---@field id string the id and file name of the object
---@field new fun() initializes the object with given id and establishes save directory
---@field save fun() saves the object to the save file
---@field load fun() loads the object from the save file

local Saveable = Class {
    ---@param id string
    init = function(self, id)
        self.id = id or "save"
        self.saveFile = love.filesystem.getSaveDirectory() .. "/" .. self.id .. ".lua"
    end,
    __tostring = function(self)
        return "Save file: " .. self.saveFile
    end
}

function Saveable:save()
    local ok, err = pcall(table.save, self, self.saveFile)
    if not ok then
        print(err)
    end
end

function Saveable:load()
    local ok, data = pcall(table.load, self, self.saveFile)

    if not ok then
        print("Error loading save file " .. self.saveFile .. ":\n" .. data)
        return
    end

    print("Load successful.")
end

return Saveable
