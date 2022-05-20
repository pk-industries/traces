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
        if not self.flags then self.flags = {} end

        if parent == nil then
            print("Parent for " .. flagname .. " is nil.")
        elseif type(parent) ~= "table" then
            print("Parent not set correctly: " .. parent)
        end
end

function Flags:setFlags()
   if self.parent == nil then error("This Flag instance doesn't have a parent to write to.") end
   if self.flagname == nil then error("This Flag class doesn't have a flagname to write to.") end

   if self.parent[self.flagname] == nil then self.parent[self.flagname] = {} end

   for flag, value in pairs(self.flags) do
        self.parent[self.flagname][flag] = value
   end
end

function Flags:loadFlags()
    if self.parent == nil then error("This Flag instance doesn't have a parent to load from.") end
    if (self.flagname == nil) then print("Flagname is nil. Loading root of parent " .. self.parent.id) end

    local table = self.parent[self.flagname]

    if table == nil or (table ~= nil and type(table) ~= "table") then
        print("Nothing to load from " .. self.parent.id .. "." .. self.flagname) 
        return
    end

    print("Loading " .. tostring(self.flagname) .. " from parent " .. self.parent.id)
    for flag, value in pairs(table) do
        if value ~= nil and type(value) ~= "table" then     
            print(flag .. ":", value)
            self.flags[flag] = value
        end
    end
    print("Done loading from parent.")
end

return Flags