--- This file holds **BASE** templates for scenes. If this file gets too big, change this to a folder with classes in separate files.


---@field table img This contains three members: image (an image), image (a loaded image), x (number), y (number). x/y are the offsets used in draw process.
local ie = Class {
    __includes = Scene
}

---@param id string The id of the scene
---@param direction string Options: n, e, s, w.
---@param x number The x coordinate within the room it resides in.
---@param y number The y coordinate within the room it resides in.
---@param isLocked boolean? States whether the scene is locked.
---@param path string The path to the image to be drawn/explored.
function ie:init(id, direction, x, y, isLocked, path)
    local image = System.graphics.createImage(path)
    Scene.init(self, id, direction, x, y, isLocked)
    self.img = {
        ["path"] = path,
        ["image"] = image,
        ["x"] = 0,
        ["y"] = 0
    }
end

function ie:draw()
    local scale = WINDOW.scale
    System.graphics.draw(self.img.image, 0, 0, 0, scale, scale, self.img.x, self.img.y)
end

function ie:keypressed(key)
    Scene.keypressed(self, key)

    local xstep = WINDOW.baseW
    local ystep = WINDOW.baseH
    local newx = self.img.x
    local newy = self.img.y
    if key == GamePad.left then
        newx = newx - xstep
        self.img.x = (newx > 0) and newx or 0
    elseif key == GamePad.right then
        newx = newx + xstep
        local wlimit = self.img.image:getWidth() - xstep
        self.img.x = (newx < wlimit) and newx or wlimit
    elseif key == GamePad.up then
        newy = newy - ystep
        self.img.y = (newy > 0) and newy or 0
    elseif key == GamePad.down then
        newy = newy + ystep
        local hlimit = self.img.image:getHeight() - ystep
        self.img.y = (newy < hlimit) and newy or hlimit
    elseif key == Controls.b then
        GameState.pop()
    end
end

local he = Class {
    __includes = ie,
    init = function(self, id, direction, x, y, isLocked, path)
        ie.init(self, id, direction, x, y, isLocked, path)
    end,
    keypressed = function(self, key)
        Scene.keypressed(self, key)

        local xstep = WINDOW.baseW
        local newx = self.img.x
        local wlimit = self.img.image:getWidth() - xstep

        if key == GamePad.left then
            newx = newx - xstep
            self.img.x = (newx >= 0) and newx or wlimit
        elseif key == GamePad.right then
            newx = newx + xstep
            self.img.x = (newx <= wlimit) and newx or 0
        elseif key == Controls.b then
            GameState.pop()
        end
    end
}


return {
    --- Creates a Scene class with an additional img table used to traverse the given image path.
    --- Image is loaded once on initialization.
    --- Table 'img' contains three members: path (str), image (a loaded image), x (number), y (number). x/y are the offsets used in draw process.
    ImageExplorer = ie,
    --- Like an image explorer, except only horizontally, and exploring wraps.
    HorizontalExplorer = he
}