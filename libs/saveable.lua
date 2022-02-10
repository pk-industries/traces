---@class Saveable
---@field init fun() initializes the object with given id and establishes save directory
---@field save fun() saves the object to the save file
---@field load fun() loads the object from the save fileq
Saveable =
    Class {
    ---@param self Saveable
    ---@param id string
    init = function(self, id)
        self.id = id
        self.saveFile = love.filesystem.getSaveDirectory() .. "/" .. id .. ".lua"
    end,
    __tostring = function(self)
        return "saveFile: " .. self.saveFile
    end,
    load = function(self)
        local tbl

        pcall(
            function()
                tbl = table.load(self.saveFile)
            end
        )

        if type(tbl) ~= "table" then
            print("Error loading " .. self.saveFile)
            table.save(self, self.saveFile)
            return nil
        else
            for k, v in pairs(tbl) do
                self[k] = v
            end
        end
    end,
    save = function(self)
        local err = table.save(self, self.saveFile)
        if not err then
            print("Saved to: " .. self.saveFile)
        else
            print("Save failed")
        end
    end
}

return Saveable
