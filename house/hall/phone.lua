local Phone = Class { __includes = Scene }
local phone, rotary, stopper

function Phone:init()
    Scene.init(self, "hall.phone", "w", 1, 2, false)
    self.pos = 0
end

function Phone:enter()
    phone = System.graphics.createImage("assets/images/hall/phone.png")
    rotary = System.graphics.createImage("assets/images/hall/phone_rotator.png")
    stopper = System.graphics.createImage("assets/images/hall/phone_stopper.png")
end

function Phone:draw()
    local scale = WINDOW.scale
    local g = System.graphics

    -- Draw phone
    g.draw(phone, 0, 0, 0, scale, scale)

    -- Draw rotary
    local rotOx = System.graphics.getImageWidth(rotary) / 2
    local rotOy = System.graphics.getImageHeight(rotary) / 2
    local posX = (WINDOW.baseW / 2) - 2
    local posY = (WINDOW.baseH / 2) + 12
    g.draw(rotary, posX * scale, posY * scale, self.pos, scale, scale, rotOx, rotOy)
end

function Phone:update()
    local old = self.pos
    if System.keyboard.isDown(Controls.right) then
        self.pos = self.pos + 1
    elseif System.keyboard.isDown(Controls.left) then
        self.pos = self.pos - 1
    end
    if old ~= self.pos then print("Pos: " .. tostring(self.pos)) end
end

return Phone