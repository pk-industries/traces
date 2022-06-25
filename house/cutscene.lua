local CutScene = Class {}

function CutScene:init(img, anim)
    self.image = img
    self.animation = anim
end

function CutScene:enter()
end

function CutScene:update(dt)
    if self.animation.status ~= "playing" then
        GameState.pop()
    end

    self.animation:update(dt)
end

function CutScene:draw()
    self.animation:draw(self.image, 0, 0, 0, WINDOW.scale, WINDOW.scale)
end

function CutScene:keypressed(key)
    if keyOf(Controls, key) ~= nil then
        GameState.pop()
    end
end

return CutScene