require "house.room"

local static = love.audio.newSource("assets/sounds/static.mp3", "stream")
local Radio = Child("radio", "e", 2, 2)
Radio.tuner = {
    xmin = 308,
    xmax = 728,
    x = 350,
    played = false
}
local stations = {}

function Radio:init()
    self.active = false
    print("Radio:init()")
end

function Radio:update(dt)
    if love.keyboard.isDown(Controls.right) then
        Radio.tuner.x = Radio.tuner.x + 0.5
        if Radio.tuner.x > Radio.tuner.xmax then
            Radio.tuner.x = Radio.tuner.xmin
        end
    elseif love.keyboard.isDown(Controls.left) then
        Radio.tuner.x = Radio.tuner.x - 0.5
        if Radio.tuner.x < Radio.tuner.xmin then
            Radio.tuner.x = Radio.tuner.xmax
        end
    end
end

function Radio:draw(key)
    local img = love.graphics.newImage("assets/images/bedroom/x2y2_e_bedroom_radio.png")
    local scale = CONFIG.window.scale
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", Radio.tuner.x, 90, 7, 100)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(img, 0, 0, 0, scale, scale)

    -- debug help
    love.graphics.setColor(200, 0, 0, 1)
    love.graphics.print("x: " .. Radio.tuner.x .. "xmin: " .. Radio.tuner.xmin .. "xmax: " .. Radio.tuner.xmax, 0, 0)
end

function Radio:keypressed(key)
    local click = love.audio.newSource("assets/sounds/button_press.wav", "static")
    if key == Controls.right then
        Radio.tuner.x = Radio.tuner.x + 1
        if Radio.tuner.x > Radio.tuner.xmax then
            Radio.tuner.x = Radio.tuner.xmin
        end
    end

    if Radio.tuner.x % 10 == 0 then
        click:play()
    end
    if key == Controls.back then
        GameState.pop()
    end
end

return Radio
