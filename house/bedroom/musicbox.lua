require "house.room"

local MusicBox =
    Child(
    "musicbox",
    "s",
    2,
    1,
    {
        init = function(self)
            up = 0
            img = love.graphics.newImage("assets/images/bedroom/musicbox_turn_sheet.png")
            frames = {}
            local frameW, frameH = love.graphics.getDimensions()

            for i = 0, 10 do
                table.insert(frames, love.graphics.newQuad(i * frameW, 0, frameW, frameH, img:getWidth(), frameH))
            end

            currentFrame = 1
        end,
        update = function(self)
        end,
        enter = function(self)
        end,
        draw = function(self)
            love.graphics.draw(img, frames[math.floor(currentFrame)])
        end,
        keypressed = function(self, key)
            if key == "space" then
                currentFrame = currentFrame + 1
                if currentFrame > #frames then
                    currentFrame = 1
                end
            end
            if key == Controls.down then
                GameState.pop()
            end
        end,
        wheelmoved = function(self, x, y)
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
    }
)

return MusicBox
