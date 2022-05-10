local g = System.graphics
local phone, rotary, stopper
local controlsAreLocked = true
local isMovingForward = false

local digits = {
    { text = "1", stop = 30 },
    { text = "2", stop = 57 },
    { text = "3", stop = 80 },
    { text = "4", stop = 108 },
    { text = "5", stop = 133 },
    { text = "6", stop = 160 },
    { text = "7", stop = 185 },
    { text = "8", stop = 213 },
    { text = "9", stop = 240 },
    { text = "0", stop = 266 },
    { text = "#", stop = 293 },
    { text = "*", stop = 315 }
}

local Phone = Class {
    __includes = Scene
}

function Phone:init()
    Scene.init(self, "hall.phone", "w", 1, 2, false)
    self.pos = 0 -- The rotary's position in degrees.
    self.selected = 1 -- User's selected phone digit.
end

function Phone:enter()
    controlsAreLocked = true

    g.setFont(Fonts.pixel[48])

    phone = g.createImage("assets/images/hall/phone.png")

    local image = g.createImage("assets/images/hall/phone_rotator.png")
    local posX = (WINDOW.baseW / 2) - 2
    local posY = (WINDOW.baseH / 2) + 12
    local oX = g.getImageWidth(image) / 2
    local oY = g.getImageHeight(image) / 2
    rotary = {
        img = image,
        pos = {
            x = posX,
            y = posY
        },
        offset = {
            x = oX,
            y = oY
        }
    }

    stopper = {
        img = g.createImage("assets/images/hall/phone_stopper.png"),
        pos = {
            x = 217,
            y = 133
        }
    }

    controlsAreLocked = false
end

function Phone:draw()
    local scale = WINDOW.scale

    -- Draw phone
    g.draw(phone, 0, 0, 0, scale, scale)

    -- Draw rotary
    local orient = math.rad(self.pos)
    local x = rotary.pos.x * scale
    local y = rotary.pos.y * scale
    g.draw(rotary.img, x, y, orient, scale, scale, rotary.offset.x, rotary.offset.y)

    -- Draw stopper
    x = stopper.pos.x * scale
    y = stopper.pos.y * scale
    g.draw(stopper.img, x, y, 0, scale, scale)

    -- Draw selected digit
    local text = digits[self.selected].text
    x = 25 * scale
    y = 14 * scale
    g.setColor(0, 0, 0)
    g.print(text, x, y , 0, scale, scale)
    g.setColor(1,1,1)
end

function Phone:update()
    if isMovingForward then
        local desiredStop = digits[self.selected].stop
        
        if self.pos < desiredStop then
            self.pos = self.pos + 2
        else
            isMovingForward = false
        end
    elseif self.pos > 0 then
        self.pos = self.pos - 4
    else
        controlsAreLocked = false
    end
end

function Phone:wheelmoved(x, y)
    if controlsAreLocked then return end

    self.selected = self.selected + y
    if self.selected > #digits then
        self.selected = 1
    elseif self.selected < 1 then
        self.selected = #digits
    end
end

function Phone:keypressed(key)
    if not controlsAreLocked and key == Controls.a then
        self:dial()
    end
end

function Phone:dial()
    controlsAreLocked = true
    isMovingForward = true
end

return Phone