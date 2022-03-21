local currentFrame

local MusicBox = Class { __includes = Scene }

function MusicBox:init()
    Scene.init(self, "bedroom.musicbox")
    self.up = 0
    self.val = 0
    self.img = System.graphics.createImage("assets/images/bedroom/musicbox_turn_sheet.png")
    self.frames = {}
    local frameW, frameH = System.graphics.getDimensions()

    for i = 0, 10 do
        table.insert(self.frames, System.graphics.createCrop(i * frameW, 0, frameW, frameH, self.img:getWidth(), frameH))
    end

    currentFrame = 1
end

function MusicBox:enter(prev, ...)
    self.val = 0
    self.alpha = 1
    self.color = {
        self.val,
        self.val,
        self.val
    }
    -- Timer.tween(2, color, {0, 0, 0}, "linear")
end

function MusicBox:update(dt)
    -- Timer.update(dt)
end

function MusicBox:draw()
    System.graphics.draw(self.img, self.frames[math.floor(currentFrame)])
    System.graphics.setBackgroundColor(Colors.white)
    System.graphics.setColor(self.color)
end

function MusicBox:keypressed(key)
    self.val = self.val + 5
    if key == "space" then
        currentFrame = currentFrame + 1
        if currentFrame > #self.frames then
            currentFrame = 1
        end
    end
    if key == GamePad.down then
        GameState.pop()
    end
    print(self.val)
end

function MusicBox:wheelmoved(x, y)
    if y > 10 then
        currentFrame = currentFrame + 1
        if currentFrame > #self.frames then
            currentFrame = 1
        end
    end
    if y < -10 then
        currentFrame = currentFrame - 1
        if currentFrame < 1 then
            currentFrame = #self.frames
        end
    end
end

-- function MusicBox:

return MusicBox
