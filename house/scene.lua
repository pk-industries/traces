local Flags = require "libs.flags"

---Scenes are interactable "areas" intended to live within a room.
---@param id string The id of the scene
---@param isLocked boolean? States whether the scene is locked.
---@field string id The id of the scene
---@field boolean isLocked States whether a scene is locked. Usually indicates whether resources
---for a scene will be loaded or not.
local Scene = Class {
    __includes = Flags
 }

---@param id string The id of the scene
---@param isLocked boolean? States whether the scene is locked.
function Scene:init(id, isLocked)
    Flags.init(self, id, Player)
    self.id = id
    self.flags.isLocked = isLocked or false
end

function Scene:enter()
    print("Entering scene " .. self.id)

    local ok, err = pcall(self.loadFlags, self)
    if not ok then print(err) end

    print("Flags loaded.")
end

function Scene:leave()
    print("Exiting scene " .. self.id)

    local ok, err = pcall(self.setFlags, self)
    if not ok then print(err) end

    print("Flags set.")
end

function Scene:draw() if DEBUG then self:drawDebug() end end

function Scene:drawDebug()
    local g = System.graphics
    g.setFont(Fonts.pixel[30])
    g.setColor(0, 0, 0)
    g.print("Scene " .. self.id, 0, 0)
    g.setColor(1, 1, 1)
end

function Scene:keypressed(key)
    print(tostring(key))
    if key == Controls.start then
        self:pause()
    elseif key == Controls.b then
        GameState.pop()
    elseif key == CONFIG.debug.key then
        DEBUG = not DEBUG
    end
end

local paused = false
function Scene:update()
    if GameState.current() == self and paused then self:resume() end
end

function Scene:pause()
    paused = true
    GameState.push(States.pause)
end

function Scene:resume() paused = false end

return Scene
