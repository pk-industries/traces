local Couch = Class { __includes = Scene }

function Couch:init()
    Scene.init(self, "livingroom.couch", "w", 3, 2 , false)
end

function Couch:draw()
    local img = System.graphics.createImage("assets/images/livingroom/x2y2_livingroom.png")
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Couch:keypressed(key)
    if key == GamePad.up or key == Controls.b then
        GameState.pop()
    end
end

return Couch