---@class Saveable
---@field saveFile string the name of the file that this instance saves and loads to
---@field id string the id and file name of the object
---@field new fun() initializes the object with given id and establishes save directory
---@field save fun() saves the object to the save file
---@field load fun() loads the object from the save file

local Saveable =
    Class {
    ---@param id string
    init = function(self, id)
        self.id = id or "save"
        self.saveFile = love.filesystem.getSaveDirectory() .. "/" .. self.id .. ".lua"
        print("Save file: " .. self.saveFile)
    end,
    __tostring = function(self)
        return "Save file: " .. self.saveFile
    end
}

function Saveable:save()
    local ok, err = love.filesystem.write(self, self.saveFile)
    if ok then
        print("Saved to: " .. self.saveFile)
    else
        print("Save failed:\n" .. err)
    end
end

function Saveable:load()
    print("Save file " .. self.savefile .. " loading...")
    
    print("Skipping load, this is a dummy load.")
--     local getfileinfo = function()
--         pcall(love.filesystem.getInfo, self.saveFile, '"file"')
--     end
--     local loadfile = function()
--         pcall(love.filesystem.load, self.saveFile)
--     end
--     local runload = function(chunk)
--         pcall(chunk)
--     end

--     local printerr = function(err)
--         print("Error loading " .. self.savefile .. ":\n" .. tostring(err))
--     end
--     local printloadskip = function()
--         print("No save data for " .. self.saveFile .. "\nSkipping load.")
--     end
    
--     local ok, data = getfileinfo()

--     if not ok then
--         -- printerr(data)
--         print("Error loading " .. self.savefile .. ":\n" .. tostring(data))
--     elseif not data then
--         printloadskip()
--     else
--         ok, data = loadfile()

--         if not ok then
--             -- printerr(data)
--             print("Error loading " .. self.savefile .. ":\n" .. tostring(data))
--         else
--             ok, data = runload(data)

--             if not ok then
--                 -- printerr(data)
--                 print("Error loading " .. self.savefile .. ":\n" .. tostring(data))
--             end
--         end
--     end
end

return Saveable
