local FlashingPrompt = Class {
    init = function(self, text, x, y, speed)
        self.text = text or "text"
        self.x = x or 0
        self.y = y or 0
        self.speed = speed or 0.1

        self.on = false -- Turn routine off or on.
        self.dim = false -- Flag for 'dimming' or brightening the prompt.
        self.val = 0 -- Dimming value.
    end,
    routine = function(self)
        if not self.on then return end

        local g = System.graphics
        local scale = WINDOW.scale
        local x = self.x * scale
        local y = self.y * scale

        self.val = self.dim and self.val - self.speed or self.val + self.speed

        if self.val < 0.1 then
            self.dim = false
        elseif self.val > 0.9 then
            self.dim = true
        end

        g.setColor(self.val, self.val, self.val)
        g.print(self.text, Fonts.pixel[15], x, y, 0, scale, scale)
        g.setColor(1, 1, 1)
    end
}

return FlashingPrompt
