local NightStand = Class { __includes = Scene }

function NightStand:init()
    Scene.init(self, "bedroom.radio", false)
end

function NightStand:draw()
    local img = System.graphics.createImage("assets/images/bedroom/radio.png")
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
end

function NightStand:keypressed(key)
    if key == GamePad.down then
        GameState.pop()
    end
end

return NightStand