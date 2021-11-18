require "house.room"

local Radio = Child("radio", "e", 2, 2, {})

function Radio:init()
    self.active = false
    print("Radio:init()")
end

function Radio:draw(key)
    local img = love.graphics.newImage("assets/images/bedroom/x2y2_e_bedroom_radio.png")
    local scale = CONFIG.window.scale
    love.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Radio:keypressed(key)
    if key == Controls.back then
        GameState.pop()
    end
end

return Radio
