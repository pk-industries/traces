-- darkScreen is used for fading to black and adding darkness to the screen

darkScreen = {}
darkScreen.state = 0 -- 0 is stable, 1 is getting dark, -1 is getting lighter
darkScreen.alpha = 0
darkScreen.time = 1 -- time in seconds for the blackScreen fade/unfade

gameWidth = 400
gameHeight = 240
scale = 1

function darkScreen:update(dt)

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

function darkScreen:draw()

  love.graphics.setColor(1, 0, 0, self.alpha)
  love.graphics.rectangle("fill", -20, -20, (gameWidth + 40) * scale, (gameHeight + 40) * scale)

end

function darkScreen:fadeIn(t)

  self.alpha = 1
  self.state = -1
  self.time = t or 1

end

function darkScreen:fadeOut(t)

  self.alpha = 0
  self.state = 1
  self.time = t or 1

end