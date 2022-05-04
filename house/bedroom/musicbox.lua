local MusicBox = Class { __includes = Scene }

function MusicBox:init()
    Scene.init(self, "bedroom.musicbox")
    self.frames = {}

    for i = 0, 10 do
        self.frames[i + 1] = System.graphics.createImage("assets/images/bedroom/musicbox/musicbox-" .. tostring(i) .. ".png")
    end

    self.currentFrame = 1
end

function MusicBox:enter()
end

function MusicBox:draw()
    System.graphics.draw(self.frames[self.currentFrame], 0, 0, 0, WINDOW.scale, WINDOW.scale)
end

function MusicBox:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    Scene.keypressed(self, key)
end

function MusicBox:wheelmoved(x, y)
    local f = self.currentFrame + y
    local total = #self.frames
    if f > total then
        self.currentFrame = 1
    elseif f < 1 then
        self.currentFrame = total
    else
        self.currentFrame = f
    end
end

return MusicBox
