local Flags = require "libs.flags"

---@field string id
---@field number width
---@field number height
---@field table scene
---@field table obstacles Fill table with ["x.y"] coordinates as the key and the illegal cardinal directions in a table as the value.
local Room = Class { __includes = Flags }

---Constructor
---@param id string
---@param width number
---@param height number
---@param scenes table
---@param obstacles table Fill table with ["x.y"] coordinates as the key and the illegal cardinal directions in a table as the value.
function Room:init(id, width, height, scenes, obstacles)
    Flags.init(self, id, Player)
    self.id = id or "room"
    self.width = width
    self.height = height
    self.scenes = scenes or {}
    self.obstacles = obstacles or {}
    self:loadFlags()
end

function Room:enter()
    System.setTitle(GameState.current().id)
end

function Room:update(dt)
    Timer.update(dt)
end

function Room:draw()
    local _, err = pcall(function()
        self:render()
    end)
    if err then
        print(err)
    end
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
    print(key)
    if key == GamePad.start then
        GameState.push(States.pause)
    elseif key == Controls.d then
        Player.isDarkOn = not Player.isDarkOn
    elseif key == Controls.z then
        Player.isFlashOn = not Player.isFlashOn
    elseif key == Controls.u then
        local facingscene = getFacingScene(self)
        if facingscene then
            print("Changing scene lock for " .. facingscene.id .. " to " .. tostring(not facingscene.isLocked))
            facingscene.isLocked = not facingscene.isLocked
        end
    elseif key == Controls.up then
        local facingscene = getFacingScene(self)
        if facingscene then
            if facingscene.isDoor then
                facingscene:openDoor()
                if not facingscene.flags.isLocked then
                    Player.room = facingscene.id
                    Player:setPosition(facingscene.destD, facingscene.destX, facingscene.destY)
                    facingscene:openDoor()
                    States.game:enter()
                end
            elseif not facingscene.flags.isLocked then
                GameState.push(House[facingscene.id])
            end
            return
        end
    end
    local ok, err = pcall(function()
        self:navigate(key)
    end)
    if not ok then
        print(err)
    end
end

---@param isMovingForward boolean If this is false, it is assumed moving backward.
local function checkForObstacle(room, d, x, y, isMovingForward)
    local key = tostring(x) .. "." .. tostring(y)
    local cardinal = d
    print("Cardinal: " .. cardinal)
    if not isMovingForward then
        cardinal = Cardinals.getOpposite(cardinal)
        print("Opposite needed: " .. tostring(cardinal))
    end
    local coordinates = cardinal .. "." .. key
    return keyOf(room.obstacles, coordinates) ~= nil
end

function Room:navigate(key)
    if key == "`" then
        self.debug = not self.debug
        return
    end
    if not GamePad.includes[key] then
        return
    end
    if key == Controls.up or key == Controls.down then
        local d, x, y = Player:getPosition()
        local isMovingForward = key == Controls.up
        if (checkForObstacle(self, d, x, y, isMovingForward)) then
            print("There's an obstacle in the way.")
            return
        end
    end
    Player:move(key)
end

function Room:render()
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/"
    local filename = "x" .. x .. "y" .. y .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = WINDOW.scale
    System.graphics.setColor(255, 255, 255)
    if System.filesystem.checkFileExists(filepath) then
        local image = System.graphics.createImage(filepath)
        local offsetTbl = {
            ["n"] = 0,
            ["s"] = 400,
            ["e"] = 800,
            ["w"] = 1200
        }
        local offset = offsetTbl[d]
        System.graphics.draw(image, 0, 0, 0, scale, scale, offset)
    else
        print("File " .. filepath .. " does not exist :(")
    end
    Flashlight.runRoutine()
end

function Room:wheelmoved(x, y)
    if type(self.scene) == "table" then
        self.scene:wheelmoved(x, y)
    end
end

return Room