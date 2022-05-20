local Flags = require "libs.flags"

---Scenes are interactable "areas" intended to live within a room.
---@param id string The id of the scene
---@param direction string Options: n, e, s, w
---@param x number The x coordinate within the room it resides in.
---@param y number The y coordinate within the room it resides in.
---@param isLocked boolean? States whether the scene is locked.
---@field string id The id of the scene
---@field string direction The cardinal direction in regards to it's location in the room. In char form.
---@field number x The x coordinate within the room it resides in.
---@field number y The y coordinate within the room it resides in.
---@field boolean isLocked States whether a scene is locked. Usually indicates whether resources
---for a scene will be loaded or not.
local Scene = Class {
    __includes = Flags
}

---@param id string The id of the scene
---@param direction string Options: n, e, s, w.
---@param x number The x coordinate within the room it resides in.
---@param y number The y coordinate within the room it resides in.
---@param isLocked boolean? States whether the scene is locked.
function Scene:init(id, direction, x, y, isLocked)
    Flags.init(self, id, Player)
    self.id = id
    self.direction = direction
    self.x = x
    self.y = y
    self.flags.isLocked = isLocked or false
end

function Scene:enter()
    print("Entering scene " .. self.id)

    local ok, err = pcall(self.loadFlags, self)
    if not ok then
        print(err)
    end

    print("Flags loaded.")
end

function Scene:draw()
    System.setFont(Fonts.pixel[30])
    System.print("Scene " .. self.id, 0, 0)
end

function Scene:leave()
    print("Exiting scene " .. self.id)

    local ok, err = pcall(self.setFlags, self)
    if not ok then
        print(err)
    end

    print("Flags set.")
end

function Scene:keypressed(key)
    print(tostring(key))
    if key == Controls.start then
        GameState.push(States.pause)
    elseif key == Controls.b then
        GameState.pop()
    end
end

return Scene