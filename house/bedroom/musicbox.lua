local MusicBox = Class { __includes = Scene }

function MusicBox:init()
    Scene.init(self, "bedroom.musicbox")
    self.frames = {}
    self.flags.currentFrame = 1
end

function MusicBox:enter()
    for i = 0, 10 do
        self.frames[i + 1] = System.graphics.createImage("assets/images/bedroom/musicbox/musicbox-" .. tostring(i) .. ".png")
    end
    Scene.enter(self)
end

function MusicBox:leave()
    for i = 0, 10 do
        self.frames[i + 1] = nil
    end
    Scene.leave(self)
end

function MusicBox:draw()
    System.graphics.draw(self.frames[self.flags.currentFrame], 0, 0, 0, WINDOW.scale, WINDOW.scale)
    Scene.draw(self)
end

function MusicBox:keypressed(key)
    if key == Controls.down then
        GameState.pop()
    end
    Scene.keypressed(self, key)
end

function MusicBox:wheelmoved(x, y)
    local f = self.flags.currentFrame + y
    local total = #self.frames
    if f > total then
        self.flags.currentFrame = 1
    elseif f < 1 then
        self.flags.currentFrame = total
    else
        self.flags.currentFrame = f
    end
end

return MusicBox
