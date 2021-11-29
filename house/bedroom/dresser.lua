local MusicBox = require "house.bedroom.musicbox"
local Scene = require "libs.scene"

local Dresser = Scene("bedroom.dresser", {})
function Dresser:init()
end
function Dresser:draw()
    local img = love.graphics.newImage("assets/images/bedroom/dresser_bedroom.png")
    local scale = WINDOW.scale
    love.graphics.draw(img, 0, 0, 0, scale, scale)
end

function Dresser:keypressed(key)
    if key == Controls.up and love.keyboard.isDown(Controls.left) then
        GameState.push(MusicBox)
    end
    if key == Controls.back then
        GameState.pop()
    end
end

return Dresser
