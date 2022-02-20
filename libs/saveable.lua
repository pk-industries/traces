---@class Saveable
---@field init fun() initializes the object with given id and establishes save directory
---@field save fun() saves the object to the save file
---@field load fun() loads the object from the save file
Saveable =
    Class {
    ---@param id string
    init = function(self, id)
        self.id = id
        self.saveFile = love.filesystem.getSaveDirectory() .. "/" .. id .. ".sav"
        print("This save file: " .. self.saveFile)
    end,
    __tostring = function(self)
        return "saveFile: " .. self.saveFile
    end,
    load = function(self)
        if not love.filesystem.exists(self.saveFile) then
            print("No save file for " .. self.saveFile .. " exists. Skipping load.")
            return nil
        end
        
        local ok, chunk = pcall(love.filesystem.load, self.saveFile)

        if not ok then
            print("Error loading " .. self.saveFile .. ":\n" .. tostring(chunk))
        else
            ok, result = pcall(chunk)

            if not ok then
                print("Error loading chunk from" .. self.saveFile .. ":\n" .. tostring(result))
            else
                for k, v in pairs(result) do
                    self[k] = v
                end 
            end
        end
    end,
    save = function(self)
        local ok, err = love.filesystem.write(self, self.saveFile)
        if ok then
            print("Saved to: " .. self.saveFile)
        else
            print("Save failed: " .. err)
        end
    end
}

return Saveable