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

function ie:update()
    local xstep = WINDOW.baseW / 100
    local ystep = WINDOW.baseH / 100
    local newx = self.img.x
    local newy = self.img.y
    if System.keyboard.isDown(GamePad.left) then
        newx = newx - xstep
        self.img.x = (newx > 0) and newx or 0
    end
    if System.keyboard.isDown(GamePad.right) then
        newx = newx + xstep
        local wlimit = self.img.image:getWidth() - WINDOW.baseW
        self.img.x = (newx < wlimit) and newx or wlimit
    end
    if System.keyboard.isDown(GamePad.up) then
        newy = newy - ystep
        self.img.y = (newy > 0) and newy or 0
    end
    if System.keyboard.isDown(GamePad.down) then
        newy = newy + ystep
        local hlimit = self.img.image:getHeight() - WINDOW.baseH
        self.img.y = (newy < hlimit) and newy or hlimit
    end
end

return {
    --- Creates a Scene class with an additional img table used to traverse the given image path.
    --- Image is loaded once on initialization.
    --- Table 'img' contains three members: path (str), image (a loaded image), x (number), y (number). x/y are the offsets used in draw process.
    ImageExplorer = ie
}