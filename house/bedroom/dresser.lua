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
            love.graphics.setColor(255, 0, 0)
            love.graphics.print("y: " .. up, 0, 0)
            love.graphics.setColor(255, 255, 255)
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
            up = y
            print("wheelmoved: %d, %d", x, y)
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

local Dresser =
    Child(
    "dresser",
    "s",
    2,
    1,
    {
        init = function(self)
        end,
        update = function(self)
        end,
        enter = function(self)
            print(self.id .. ": init()")
        end,
        draw = function(self)
            local img = love.graphics.newImage("assets/images/bedroom/dresser_bedroom.png")
            local scale = CONFIG.window.scale
            love.graphics.draw(img, 0, 0, 0, scale, scale)
        end,
        leave = function(self)
            print(self.id .. ": leave()")
        end,
        keypressed = function(self, key)
            if key == Controls.up and love.keyboard.isDown(Controls.left) then
                GameState.push(MusicBox)
            end
            if key == Controls.back then
                GameState.pop()
            end
        end
    }
)

return Dresser
