require "house.room"

local static = love.audio.newSource("assets/sounds/static.mp3", "stream")
local click = love.audio.newSource("assets/sounds/button_press.wav", "static")

local Radio = Child("radio", "e", 2, 2)
Radio.tuner = {
    xmin = 308,
    xmax = 728,
    x = 0,
    velx = 0
}

local stations = {}

function Radio:init()
    self.active = false
    Radio.tuner.x = Radio.tuner.xmin
    print("Radio:init()")
end

function Radio:enter()
end

function Radio:update(dt)
    local newpos = Radio.tuner.x + Radio.tuner.velx * dt
    print(newpos)
    if newpos > Radio.tuner.xmin and newpos < Radio.tuner.xmax then
        Radio.tuner.x = newpos
    end
    -- Gradually reduce the velocity to create smooth scrolling effect.
    Radio.tuner.velx = Radio.tuner.velx - Radio.tuner.velx * math.min(dt * 15, 1)
end

function Radio:draw(key)
    local img = love.graphics.newImage("assets/images/bedroom/x2y2_e_bedroom_radio.png")
    local scale = CONFIG.window.scale
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", Radio.tuner.x, 90, 7, 100)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(img, 0, 0, 0, scale, scale)
end

function love.wheelmoved(dx, dy)
    Radio.tuner.velx = Radio.tuner.velx + dy * 20
end

function Radio:keypressed(key)
    if key == Controls.back then
        GameState.pop()
    end
end

return Radio
