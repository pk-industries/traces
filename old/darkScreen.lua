-- darkScreen is used for fading to black and adding darkness to the screen
-- TODO: i can't get this to work rn bc fade to black starts AFTER loading a room
-- i'll come back to this w/ a library or playdate sdk.....
DarkScreen = {}
DarkScreen.entered = false
GameWidth = 400
GameHeight = 240
Scale = 1
DarkScreen.r = 255
DarkScreen.g = 255
DarkScreen.b = 255

function DarkScreen:load() end

function DarkScreen:update(dt)
    DarkScreen.r = DarkScreen.r - 550 * dt
    DarkScreen.g = DarkScreen.g - 550 * dt
    DarkScreen.b = DarkScreen.b - 550 * dt
end

function DarkScreen:draw()
    love.graphics.setColor(DarkScreen.r / 255, DarkScreen.g / 255,
                           DarkScreen.b / 255)
    love.graphics.rectangle("fill", -20, -20, (GameWidth + 40) * Scale,
                            (GameHeight + 40) * Scale)
end
