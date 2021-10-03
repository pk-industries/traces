-- Binser is a lua serializer: https://github.com/bakpakin/binser
local Binser = 'vendor.binser.binser'
local Saver  = {}

-- Write to save file
--
function Saver:save(name, data)
    love.filesystem.write(name .. '.txt', Binser.serialize(data))

    return data
end

-- Load save file
--
function Saver:load(name)
    if self:exists(name) then
        local data, size = love.filesystem.read(name .. '.txt')

        return Binser.deserialize(data)[1]
    end

    return false
end

-- File exists?
--
function Saver:exists(name)
    return self:getInfo(name) ~= nil
end

-- Get file info
--
function Saver:getInfo(name)
    return love.filesystem.getInfo(name .. '.txt', 'file')
end

return Saver