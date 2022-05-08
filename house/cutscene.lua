local CutScene = Class {}
local image, animation

function CutScene:init(img, anim)
    image = img
    animation = anim
end

function CutScene:update(dt)
    if animation.status ~= "playing" then
        GameState.pop()
    end

    animation:update(dt)
end

function CutScene:draw()
    animation:draw(image, 0, 0, 0, WINDOW.scale, WINDOW.scale)
end

function CutScene:keypressed(key)
    if keyOf(Controls, key) ~= nil then
        GameState.pop()
    end
end

return CutScene