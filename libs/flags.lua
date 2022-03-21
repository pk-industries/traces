local Class = require "libs.class"

local Flags =
    Class {
    __tostring = function(self)
        for flag, value in pairs(self) do
            print("Flags:\n" .. flag .. ": " .. value)
        end
    end
}

function Flags:init(flagname, parent)
        self.flagname = flagname
        self.parent = parent

        if parent == nil then
            print("Parent for " .. flagname .. " is nil.")
        elseif type(parent) ~= "table" then
            print("Parent not set correctly: " .. parent)
        end
end

function Flags:setFlags()
   if self.parent == nil then error("This Flag instance doesn't have a parent to write to.") end
   for flag, value in pairs(self.parent[self.flagname]) do
        if value ~= value and type(value) == "table" then
            self.parent[flag] = value
        end
   end
end

function Flags:loadFlags()
    if self.parent == nil then error("This Flag instance doesn't have a parent to load from.") end
    if (self.flagname == nil) then print("Flagname is nil. Loading root of parent " .. self.parent.id) end

    local table = self.parent[self.flagname]

    if table == nil then
        print("Nothing to load from " .. self.parent.id .. "." .. self.flagname) 
        return
    end

    if table ~= nil and type(table) ~= "table" then return end

    print("Loading " .. tostring(self.flagname) .. " from parent " .. self.parent.id)
    for flag, value in pairs(table) do
        if value ~= nil and type(value) ~= "table" then     
            print(flag .. ":", value)
            self[flag] = value
        end
    end
    print("Done loading from parent.")
end

return Flags