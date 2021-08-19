-- darkScreen is used for fading to black and adding darkness to the screen
--TODO: Use this on room change, most likely when [room].entered value changes.

DarkScreen = {}
DarkScreen.state = 0 -- 0 is stable, 1 is getting dark, -1 is getting lighter
DarkScreen.alpha = 0
DarkScreen.time = 1 -- time in seconds for the blackScreen fade/unfade

GameWidth = 400
GameHeight = 240
Scale = 1

function DarkScreen:update(dt)

  if self.state ~= 0 then
    self.alpha = self.alpha + (self.state / self.time * dt)
  end

  if self.alpha < 0 then
    self.alpha = 0
    self.state = 0
  end

  if self.alpha > 1 then
    self.alpha = 1
    self.state = 0
  end

end

function DarkScreen:draw()

  love.graphics.setColor(1, 0, 0, self.alpha)
  love.graphics.rectangle("fill", -20, -20, (GameWidth + 40) * Scale, (GameHeight + 40) * Scale)

end

function DarkScreen:fadeIn(t)

  self.alpha = 1
  self.state = -1
  self.time = t or 1

end

function DarkScreen:fadeOut(t)

  self.alpha = 0
  self.state = 1
  self.time = t or 1

end