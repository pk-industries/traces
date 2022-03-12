local static
-- local click = System.graphics.createAudioSource("assets/sounds/button_press.wav", "static")

local xmin = 154
local xmax = 364
local velx = 0
local station, music

local Radio =
    Scene(
    "bedroom.radio",
    {
        x = xmin
    }
)

--[[ stations[2] = {
    id = "masquerade-of-the-ghosts",
    min = 199,
    max = 203,
    filePath = "assets/sounds/masquerade-of-the-ghosts.mp3"
} ]]
local function isInRange(x, min, max)
    return x >= min and x <= max
end
function Radio:init()
    print("radio init")
    Saveable.init(self, "bedroom.radio")
    station = {
        id = "masquerade-of-the-ghosts",
        min = 287,
        max = 291,
        filePath = "assets/sounds/masquerade-of-the-ghosts.mp3",
        vol = 0
    }
    music = System.audio.createSource(station.filePath, "static")
    music:setLooping(true)
    music:play()

    static = System.audio.createSource("assets/sounds/static.mp3", "stream")
    static:setLooping(true)
    static:play()
    if isInRange(self.x, station.min, station.max) then
        music:play()
        static:pause()
    else
        music:pause()
        static:play()
    end
    Timer.tween(
        10,
        station,
        {vol = 1},
        "linear",
        function()
            music:setVolume(station.vol)
            static:setVolume(station.vol)
        end
    )

    

    local wheelmoved = function (dx, dy)
        velx = velx + dy * 20
    end

    System.setWheelMoved(wheelmoved)
end

-- function Radio:enter()
--     static:play()
-- end

function Radio:update(dt)
    local newpos = Radio.x + velx * dt
    if newpos > xmin and newpos < xmax then
        Radio.x = newpos
    end

    if isInRange(Radio.x, station.min, station.max) then
        music:play()
        static:pause()
    else
        music:pause()
        static:play()
    end

    -- Gradually reduce the velocity to create smooth scrolling effect.
    velx = velx - velx * math.min(dt * 15, .5)
    Timer.update(dt)
end

function Radio:draw()
    if self.currentStation then
        System.graphics.print("Current station: " .. stations[self.currentStation].id, 0, 10)
    end
    local img = System.graphics.createImage("assets/images/bedroom/x2y2_e_bedroom_radio.png")
    local scale = WINDOW.scale
    System.graphics.setColor(0, 0, 0, 1)
    System.graphics.drawRectangle("fill", Radio.x * WINDOW.scale, 45 * WINDOW.scale, 3 * WINDOW.scale, 50 * WINDOW.scale)
    System.graphics.setColor(1, 1, 1, 1)
    System.graphics.draw(img, 0, 0, 0, scale, scale)
    System.graphics.setColor(0, 0, 0)
    System.graphics.print("x: " .. Radio.x, 0, 0)
end

function Radio:keypressed(key)
    if key == Controls.b then
        GameState.pop()
    end
end

function Radio:leave()
    States.game.setBedroomRadio = true
    Player.setRadio = self.save(self)
end

return Radio
