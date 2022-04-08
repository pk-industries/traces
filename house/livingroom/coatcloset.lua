local CoatCloset = Class { __includes = Scene }

function CoatCloset:init()
    Scene.init(self, "livingroom.coatcloset", "n", 1, 3, false)
end

function CoatCloset:draw()
    local img = System.graphics.createImage("assets/images/livingroom/coatcloset.png")
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
end

function CoatCloset:keypressed(key)
    if key == GamePad.down or key == Controls.b then
        GameState.pop()
    end
end

return CoatCloset