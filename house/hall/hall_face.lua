local HallFace = Class {
    __includes = CutScene
 }

function HallFace:init()
    local g = System.graphics

    local image = g.createImage("assets/images/hall/face_animation_sheet.png")
    local w = g.getImageWidth(image)
    local h = g.getImageHeight(image)
    local grid = Anim8.newGrid(w / 6, h / 6, w, h)
    local a = Anim8.newAnimation(
                  grid(
                      "1-6", 1, "1-6", 2, "1-6", 3, "1-6", 4, "1-6", 5, "1-4", 6
                  ), 0.2, 'pauseAtEnd'
              )

    CutScene.init(self, image, a)
end

-- function HallFace:draw()
-- System.graphics.setBackgroundColor(Colors.black)
-- CutScene.draw(self)
-- end

function HallFace:update(dt)
    if self.animation.status ~= "playing" then
        self:endDemo()
        return
    end
    self.animation:update(dt)
end

function HallFace:keypressed() self:endDemo() end

function HallFace:endDemo()
    States.pause.locked = true
    Player.direction = "w"
    GameState.push(States.pause)
end

return HallFace
