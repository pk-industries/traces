local Flags = require "libs.flags"

---@field string id
---@field number width
---@field number height
---@field table scene
---@field table obstacles Fill table with ["x.y"] coordinates as the key and the illegal cardinal directions in a table as the value.
local Room = Class {
    __includes = Flags
}

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
    print("Fading in")
    Fade.fadeIn()
    System.setTitle(GameState.current().id)
end

function Room:update(dt)
    Timer.update(dt)
end

function Room:draw()
    local _, err = pcall(Room.render, self)
    if not err then
        return
    end
    print(err)
end

local function getFacingScene(self, key)
    local d, x, y = Player:getPosition()
    local coor = d .. "." .. x .. "." .. y

    if key and key ~= Controls.up then
        coor = coor .. "." .. key
    end
    
    for scenecoordinates, scene in pairs(self.scenes) do
        if scenecoordinates == coor then
            print("Scene matched")
            return scene
        end
    end
    return nil
end

function Room:keypressed(key)
    print(key)
    if Fade.interrupt() then return end
    if key == GamePad.start then
        GameState.push(States.pause)
    elseif key == Controls.d then
        Player.isDarkOn = not Player.isDarkOn
    elseif key == Controls.z then
        Player.isFlashOn = not Player.isFlashOn
    elseif key == Controls.u then
        local facingscene = getFacingScene(self)
        if facingscene then
            local isLocked = Player[facingscene.id].isLocked
            print("Changing scene lock for " .. facingscene.id .. " to " .. tostring(not isLocked))
            Player[facingscene.id].isLocked = not isLocked
        end
    else
        local facingscene = getFacingScene(self, key)
        if facingscene then
            if facingscene.isDoor then
                facingscene:openDoor()
            elseif not facingscene.flags.isLocked then
                GameState.push(House[facingscene.id])
            end
            return
        end
    end
    local ok, err = pcall(Room.navigate, self, key)
    if not ok then
        print(err)
    end
end

---@param isMovingForward boolean If this is false, it is assumed moving backward.
local function checkForObstacle(room, d, x, y, isMovingForward)
    local key = tostring(x) .. "." .. tostring(y)
    local cardinal = d
    if not isMovingForward then
        cardinal = Cardinals.getOpposite(cardinal)
    end
    local coordinates = cardinal .. "." .. key
    return keyOf(room.obstacles, coordinates) ~= nil
end

function Room:navigate(key)
    if key == CONFIG.debug.key then
        DEBUG = not DEBUG
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
    Fade.draw()
end

return Room
