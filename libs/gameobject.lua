---@class GameObject
---@field room RoomName
---@field direction Direction
---@field x number
---@field keyreleased love.keyreleased
---@field keypressed love.keypressed
---@field mousepressed love.mousepressed
---@field mousereleased love.mousereleased
---@field mousemoved love.mousemoved
---@field update love.update
---@field draw love.draw
local GameObject =
    Class {
    ---@param room RoomName
    ---@param direction Direction
    ---@param x number
    ---@param y number
    init = function(self, room, direction, view, x, y)
        ---@alias GameObject.room  RoomName
        self.room = "bedroom"
        self.direction = "n"
        self.y = 1
        self.x = 2
        self.exits = Rooms:getRoomExits(self.room)
        self.views = Rooms:getRoomViews(self.room)
        self.exit = self:isexit()
        self.view = self:isview()
        self.bgimg = self:getbgimg()

        for k, v in pairs(Rooms[room]) do
            self[k] = v
        end
    end
}

function GameObject:loadsave(key)
    local save = table.load("save.lua")
    if save then
        for k, v in pairs(save) do
            self[k] = v
        end
    end
    print("GameObject.load: " .. self.room)
end

---@param key love.KeyConstant
function GameObject:move(key)
    local room = Rooms[self.room]
    local direction, x, y = self.direction, self.x, self.y
    local height, width = room.height, room.width

    local newdirection
    local newx
    local newy

    if self.direction == "n" then
        if key == Controls.up and y + 1 <= height then
            self.y = self.y + 1
        elseif key == Controls.right then
            self.direction = "e"
        elseif key == Controls.down and y - 1 >= 1 then
            self.y = self.y - 1
        elseif key == Controls.left then
            self.direction = "w"
        end
    elseif self.direction == "e" then
        if key == Controls.up and x + 1 <= width then --
            self.x = x + 1
        elseif key == Controls.right then
            self.direction = "s"
        elseif key == Controls.down and x - 1 >= 1 then
            self.x = x - 1
        elseif key == Controls.left then
            self.direction = "n"
        end
    elseif self.direction == "s" then
        if key == Controls.up and y - 1 >= 1 then
            self.y = y - 1
        elseif key == Controls.right then
            self.direction = "w"
        elseif key == Controls.down and y + 1 <= height then
            self.y = y + 1
        elseif key == Controls.left then
            self.direction = "e"
        end
    elseif self.direction == "w" then
        if key == Controls.up and x - 1 >= 1 then
            self.x = x - 1
        elseif key == Controls.right then
            self.direction = "n"
        elseif key == Controls.down and x + 1 <= width then
            self.x = x + 1
        elseif key == Controls.left then
            self.direction = "s"
        end
    end
    -- self.exit = self:isexit()
    -- self.view = self:isview()
    -- self.bgimg = self:getbgimg()
    print("{  " .. self.direction .. ", " .. self.x .. " , " .. self.y .. ", " .. " }")
end

function GameObject:getbgimg(view)
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. self.room .. "/" --- /assets/images/bedroom/
    local filename = "x" .. self.x .. "y" .. self.y .. "_" .. self.direction .. "_" .. self.room .. ".png"

    local filepath = roomdir .. filename

    if love.filesystem.getInfo(filepath) then
        return filepath
    else
        print("File not found: " .. filepath)
        return roomdir .. "x1y1_n_" .. self.room .. ".png"
    end
end

function GameObject:isexit()
    local exit = nil
    for k, v in pairs(self.exits) do
        local wall, x, y = v.wall, v.x, v.y
        if wall == self.direction and x == self.x and y == self.y then
            print("exit found: " .. k)
            return k
        end
    end
    return exit
end

function GameObject:isview()
    local view = nil
    for k, v in pairs(self.views) do
        local wall, x, y = v.direction, v.x, v.y
        if wall == self.direction and x == self.x and y == self.y then
            print("view found: " .. k)
            self.view = self.views[k]
            return self.views[k]
        end
    end
    return view
end

-- function GameObject:keypressed(self, key, code)
--     if Controls.arrowkeys[key] then -- if the key is [up|down|left|right]
--         self:move(key)
--     end
-- end

-- GameObject.draw = function(self)
--     love.graphics.draw(GameObject:bgimg(), 0, 0, 0, CONFIG.window.scale, CONFIG.window.scale)
-- end

return GameObject
