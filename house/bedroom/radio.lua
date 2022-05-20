local max = 210
local pass = 135
local range = 30
local musicMin = pass - range
local musicMax = pass + range
local music, static

local Radio = Class { __includes = Scene }

function Radio:init()
    self.filePath = "assets/sounds/masquerade-of-the-ghosts.mp3"
    self.vol = 0

    music = System.audio.createSource(self.filePath, "stream")
    music:setLooping(true)

    static = System.audio.createSource("assets/sounds/static.mp3", "stream")
    static:setLooping(true)

    System.audio.play(music, static)

    self.img = System.graphics.createImage("assets/images/bedroom/radio.png")

    self.flags = { pos = 0 }

    Scene.init(self, "bedroom.radio", "e", 2, 2, false)
end

local decideVolumes = function(pos)
    if pos < musicMin or pos > musicMax then
        static:setVolume(1)
        music:setVolume(0)
    else
        local decimal = math.abs(pos - pass) / range * 2
        decimal = math.pow(decimal, 3)
        music:setVolume(1 - decimal)

        decimal = math.max(0.2, decimal)
        static:setVolume(decimal)
    end
end

function Radio:update(dt)
    decideVolumes(self.flags.pos)
end

function Radio:draw()
    local pos = self.flags.pos
    local scale = WINDOW.scale
    System.graphics.setColor(0, 0, 0, 1)
    System.graphics.drawRectangle("fill", (pos + 154) * scale, 45 * scale, 3 * scale, 50 * scale)
    System.graphics.setColor(1, 1, 1, 1)
    System.graphics.draw(self.img, 0, 0, 0, scale, scale)
    System.graphics.setColor(0, 0, 0)
    System.graphics.print("x: " .. pos, 0, 0)
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