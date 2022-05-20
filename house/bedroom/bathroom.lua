local Bathroom = Class { __includes = Scene }

function Bathroom:init()
    Scene.init(self, "bedroom.bathroom", "n", 2, 2, true)
end

function Bathroom:draw()
    local img = System.graphics.createImage("assets/images/bathroom/SinkWall.png")
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
    self.openSnd = "assets/sounds/doorknob.wav"
end

return Bathroom