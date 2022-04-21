local img = love.graphics.newImage('assets/images/darkness_overlay.png')
local drawFlash = function() local scale = WINDOW.scale; love.graphics.draw(img,0,0,0,scale,scale,scale) end
local routine = function() if Player.isFlashOn then drawFlash() end end

Flashlight = {
    flashImage = img,
    draw = drawFlash,
    runRoutine = routine
}

return Flashlight