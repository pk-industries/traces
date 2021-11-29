local Saveable =
    Class {
    init = function(self, id, args)
        self.id = "id"
        self.saveFile = love.filesystem.getSaveDirectory() .. "/" .. id .. ".lua"
        pcall(
            function()
                if args then
                    for k, v in pairs(args) do
                        self[k] = v
                    end
                end
            end
        )
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
