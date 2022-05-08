local Wakeup = Class { __includes = CutScene }

function Wakeup:init()
    System.graphics.setBackgroundColor(Colors.white)
    local image = System.graphics.createImage("assets/images/bedroom/opening_animation_sheet.png")
    local w = System.graphics.getImageWidth(image)
    local h = System.graphics.getImageHeight(image)
    local g = Anim8.newGrid(w / 4, h / 4, w, h)
    local animation = Anim8.newAnimation(g("1-4", 1, "1-4", 2, "1-4", 3, "1-2", 4), 0.4, 'pauseAtEnd')
    CutScene.init(self, image, animation)
end

return Wakeup