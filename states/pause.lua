local Pause = {}

function Pause:init()
end

function Pause:enter()
end

function Pause:leave()
end

function Pause:resume()
end

function Pause:update(dt)
end

function Pause:draw()
    local img = System.graphics.createImage("assets/images/pause.png")
    local scale = WINDOW.scale
    System.graphics.setColor(255,255,255)
    System.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Pause:keypressed(key)
    if key == GamePad.start then
        GameState.pop(self)
    end
end

return Pause