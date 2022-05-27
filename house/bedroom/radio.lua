local max = 210
local pass = 135
local range = 30
local musicMin = pass - range
local musicMax = pass + range
local music, static

local Radio = Class {
    __includes = Scene
 }

function Radio:init()
    self.filePath = "assets/sounds/masquerade-of-the-ghosts.mp3"
    self.vol = 0

    local a = System.audio
    static = a.createSource("assets/sounds/static.mp3", "stream")
    a.setLooping(static, true)

    music = a.createSource(self.filePath, "stream")
    a.setLooping(music, true)

    local start = a.getDuration(music)
    print("Got the song length: " .. tostring(start))
    start = math.random(start)
    print("Got random start: " .. tostring(start))
    a.seek(music, start)

    self.img = System.graphics.createImage("assets/images/bedroom/radio.png")

    self.flags = {
        pos = 0
     }

    Scene.init(self, "bedroom.radio", false)
end

function Radio:resume()
    System.audio.play(music, static)
    Scene.resume(self)
end

local pauseMusic = function()
    System.audio.pause(static)
    System.audio.setVolume(music, 0)
end

function Radio:pause()
    pauseMusic()
    Scene.pause(self)
end

function Radio:enter()
    self:resume()
    Scene.enter(self)
end

function Radio:leave()
    pauseMusic()
    Scene.leave(self)
end

function Radio:draw()
    local pos = self.flags.pos
    local scale = WINDOW.scale
    local g = System.graphics
    g.setColor(0, 0, 0, 1)
    g.drawRectangle(
        "fill", (pos + 154) * scale, 45 * scale, 3 * scale, 50 * scale
    )
    g.setColor(1, 1, 1, 1)
    g.draw(self.img, 0, 0, 0, scale, scale)
    Scene.draw(self)
end

function Radio:drawDebug()
    Scene.drawDebug(self)
    local g = System.graphics
    g.setColor(0, 0, 0)
    g.printf("x: " .. self.flags.pos, 0, 0, WINDOW.width, "right")
    g.setColor(1, 1, 1)
end

function Radio:decideVolumes()
    local pos = self.flags.pos
    if pos < musicMin or pos > musicMax then
        static:setVolume(1)
        music:setVolume(0)
    else
        local decimal = math.abs(pos - pass) / range * 2
        decimal = math.pow(decimal, 3)
        music:setVolume(1 - decimal)
        static:setVolume(math.max(0.2, decimal))
    end
end

function Radio:update()
    self:decideVolumes()
    Scene.update(self)
end

function Radio:wheelmoved(x, y)
    self.flags.pos = self.flags.pos + y
    if self.flags.pos < 0 then
        self.flags.pos = 0
    elseif self.flags.pos > max then
        self.flags.pos = max
    end
end

return Radio
