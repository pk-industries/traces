-- darkScreen is used for fading to black and adding darkness to the screen
--TODO: Use this on room change, most likely when [room].entered value changes.

DarkScreen = {}

function DarkScreen:load()

  GameWidth = 400
  GameHeight = 240
  Scale = 1
  DarkScreen.r = 255
  DarkScreen.g = 255
  DarkScreen.b = 255
  
end



function DarkScreen:update(dt)

  DarkScreen.r = DarkScreen.r - 1
  DarkScreen.g = DarkScreen.g - 1
  DarkScreen.b = DarkScreen.b - 1 

end

function DarkScreen:draw()

  love.graphics.setColor(DarkScreen.r/255, DarkScreen.g/255, DarkScreen.b/255)
  love.graphics.rectangle("fill", -20, -20, (GameWidth + 40) * Scale, (GameHeight + 40) * Scale)

end