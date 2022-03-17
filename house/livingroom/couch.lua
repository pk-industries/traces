local Couch = Class { __includes = Scene }

function Couch:init()
    Scene.init(self, "livingroom.couch", "a", 2, 2 , false)
end

function Couch:draw()
    local img = System.graphics.createImage("assets/images/livingroom/x2y2_livingroom.png")
    local scale = WINDOW.scale
    System.grapihcs.draw(img, 0, 0, 0, scale, scale)
end

return Couch()