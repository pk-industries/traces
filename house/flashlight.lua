local flash = love.graphics.newImage('assets/images/flashlight_overlay.png')
local drawFlash = function() local scale = WINDOW.scale; love.graphics.draw(flash,0,0,0,scale,scale,scale) end

local dark = love.graphics.newImage('assets/images/darkness_overlay.png')
local drawDark = function() local scale = WINDOW.scale; love.graphics.draw(dark,0,0,0,scale,scale,scale) end

local routine = function()
    if Player.isDarkOn then
        if Player.isFlashUnlocked and Player.isFlashOn then
            drawFlash()
        else
            drawDark()
        end
    end
end

local Flashlight = {
    flashImage = flash,
    darkImage = dark,
    runRoutine = routine
}

return Flashlight