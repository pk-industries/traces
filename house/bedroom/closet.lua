local Closet = Class { __includes = Scene }

local img = nil

function Closet:init()
    Scene.init(self, "bedroom.closet", "s", 1, 1, true)
    img = System.graphics.createImage("assets/images/bedroom/closet_close_bedroom.png")
end

function Closet:draw()
    local scale = WINDOW.scale
    System.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Closet:keypressed(key)
    if key == GamePad.up then
        GameState.pop()
    end
end

return Closet
