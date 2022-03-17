---@field string id
---@field number width
---@field number height
---@field table scene
---@field table obstacles Fill table with ["x.y"] coordinates as the key and the illegal cardinal directions in a table as the value.
local Room = Class {__includes = Saveable}

---Constructor
---@param id string
---@param width number
---@param height number
---@param scenes table
---@param obstacles table Fill table with ["x.y"] coordinates as the key and the illegal cardinal directions in a table as the value.
function Room:init(id, width, height, scenes, obstacles)
    Saveable.init(self, id or "room")
    self.width = width
    self.height = height
    self.scenes = scenes or {}
    self.obstacles = obstacles or {}
end

function Room:enter()
    System.setTitle(GameState.current().id)
end

function Room:update(dt)
    Timer.update(dt)
end

function Room:draw()
    local _, err =
        pcall(
        function()
            self:render()
        end
    )
    if err then
        print(err)
    end
end

local function checkForObstacle(self, d, x, y)
    local key = tostring(x) .. "." .. tostring(y)
    if self.obstacles[key] == nil then
        return false
    end
    return self.obstacles[key][d] ~= nil
end

local function getFacingScene(self)
    local d, x, y = Player:getPosition()
    local coor = d .. "." .. x .. "." .. y
    print("Player coordinates: " .. d .. "." .. coor)
    for scenecoordinates, scene in pairs(self.scenes) do
        print(scene.id .. " coordinates: " .. scenecoordinates)
        if scenecoordinates == coor then
            print("Scene matched")
            return scene
        end
    end
    return nil
end

function Room:keypressed(key)
    if key == Controls.up then
        local d, x, y = Player:getPosition()
        if (checkForObstacle(self, d, x, y)) then
            print("There's an obstacle in the way.")
            return
        else
            local facingscene = getFacingScene(self)
            if facingscene then
                if facingscene.isLocked then
                    print("It's locked.")
                    System.graphics.print("It's locked.")
                elseif facingscene.isDoor then
                    Player.room = facingscene.id
                    Player:setPosition(facingscene.destD, facingscene.destX, facingscene.destY)
                    States.game:enter()
                    return
                else
                    GameState.push(House[facingscene.id])
                    return
                end
            end
        end
    end
    local ok, err =
        pcall(
        function()
            self:navigate(key)
        end
    )
    if not ok then
        print(err)
    end
end

function Room:navigate(key)
    if key == "`" then
        self.debug = not self.debug
    elseif GamePad.includes[key] then
        Player:move(key)
    end
end

function Room:render()
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/"
    local filename = "x" .. x .. "y" .. y .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = WINDOW.scale
    System.graphics.setColor(255, 255, 255)
    if System.filesystem.checkExists(filepath) then
        local image = System.graphics.createImage(filepath)
        local offsetTbl = {
            ["n"] = 0,
            ["s"] = 400,
            ["e"] = 800,
            ["w"] = 1200
        }
        local offset = offsetTbl[d]
        System.graphics.draw(image, 0, 0, 0, scale, scale, offset)
    end
end

function Room:wheelmoved(x, y)
    if type(self.scene) == "table" then
        self.scene:wheelmoved(x, y)
    end
end

return Room
