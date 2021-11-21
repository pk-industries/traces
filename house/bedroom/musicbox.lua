require "house.room"

local currentFrame

local MusicBox = Child("musicbox", "s", 2, 1, {})

function MusicBox:init()
    up = 0
    img = love.graphics.newImage("assets/images/bedroom/musicbox_turn_sheet.png")
    frames = {}
    local frameW, frameH = love.graphics.getDimensions()

    for i = 0, 10 do
        table.insert(frames, love.graphics.newQuad(i * frameW, 0, frameW, frameH, img:getWidth(), frameH))
    end

    currentFrame = 1
end

function MusicBox:enter(prev, ...)
    val = 0
    alpha = 1
    color = {
        val,
        val,
        val
    }
    -- Timer.tween(2, color, {0, 0, 0}, "linear")
end

function MusicBox:update(dt)
    -- Timer.update(dt)
end

function MusicBox:draw()
    love.graphics.draw(img, frames[math.floor(currentFrame)])
    love.graphics.setBackgroundColor(Colors.white)
    love.graphics.setColor(color)
end

function MusicBox:keypressed(key)
    val = val + 5
    if key == "space" then
        currentFrame = currentFrame + 1
        if currentFrame > #frames then
            currentFrame = 1
        end
    end
    if key == Controls.down then
        GameState.pop()
    end
    print(val)
end

function MusicBox:wheelmoved(x, y)
    if y > 10 then
        currentFrame = currentFrame + 1
        if currentFrame > #frames then
            currentFrame = 1
        end
    end
    if y < -10 then
        currentFrame = currentFrame - 1
        if currentFrame < 1 then
            currentFrame = #frames
        end
    end
end

-- function MusicBox:

return MusicBox
