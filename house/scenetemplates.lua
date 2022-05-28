--- This file holds **BASE** templates for scenes. If this file gets too big, change this to a folder with classes in separate files.

local ss = Class {
    __includes = Scene
}

function ss:init(id, isLocked, path)
    Scene.init(self, id, isLocked)
    self.img = {
        ["path"] = path,
        ["image"] = nil
    }
end

function ss:enter()
    self.img.image = System.graphics.createImage(self.img.path)
    Scene.enter(self)
end

function ss:leave()
    self.img.image = nil
    Scene.leave(self)
end

function ss:draw()
    local scale = WINDOW.scale
    System.graphics.setColor(255, 255, 255)
    System.graphics.draw(self.img.image, 0, 0, 0, scale, scale)
    Scene.draw(self)
end

---@field table img This contains three members: image (an image), image (a loaded image), x (number), y (number). x/y are the offsets used in draw process.
local ie = Class {
    __includes = ss
}

---@param id string The id of the scene
---@param isLocked boolean? States whether the scene is locked.
---@param path string The path to the image to be drawn/explored.
function ie:init(id, isLocked, path)
    ss.init(self, id, isLocked, path)
    self.img.x = 0
    self.img.y = 0
end

function ie:draw()
    local scale = WINDOW.scale
    System.graphics.draw(self.img.image, 0, 0, 0, scale, scale, self.img.x, self.img.y)
    Scene.draw(self)
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
        local wlimit = System.graphics.getImageWidth(self.img.image) - WINDOW.baseW
        self.img.x = (newx < wlimit) and newx or wlimit
    end
    if System.keyboard.isDown(GamePad.up) then
        newy = newy - ystep
        self.img.y = (newy > 0) and newy or 0
    end
    if System.keyboard.isDown(GamePad.down) then
        newy = newy + ystep
        local hlimit = System.graphics.getImageHeight(self.img.image) - WINDOW.baseH
        self.img.y = (newy < hlimit) and newy or hlimit
    end
end

return {
    --- A scene with a single image that is loaded and dropped when entering and leaving it.
    --- Table 'img' contains three members: path (str), image? (an image).
    SimpleScene = ss,
    --- Creates a Scene class with an additional img table used to traverse the given image path.
    --- Table 'img' contains three members: path (str), image? (an image), x (number), y (number). x/y are the offsets used in draw process.
    ImageExplorer = ie
}