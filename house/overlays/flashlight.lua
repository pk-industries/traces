local flash = System.graphics.createImage('assets/images/flashlight_overlay.png')
local dark = System.graphics.createImage('assets/images/darkness_overlay.png')

local draw = function(img) love.graphics.draw(img, 0, 0, 0, WINDOW.scale, WINDOW.scale, WINDOW.scale) end

local routine = function()
    if Player.isDarkOn then
        if Player.isFlashUnlocked and Player.isFlashOn then
            draw(flash)
        else
            draw(dark)
        end
    end
end

local Flashlight = {
    flashImage = flash,
    darkImage = dark,
    runRoutine = routine
 }

return Flashlight
