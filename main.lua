Object = require "lib/classic"
CreateRoom = require "createRoom"
Bedroom =
    CreateRoom(
    {
        "pics/bedroom/b/b_BathWall.png",
        "pics/bedroom/b/b_BedWall.png",
        "pics/bedroom/b/b_DresserWall.png",
        "pics/bedroom/b/b_HallWall.png"
    },
    "bedroom",
    "north"
)

FRAME = false
LOCATION = false
DIRECTION = false

UP_KEY = "up"
RIGHT_KEY = "right"
DOWN_KEY = "down"
LEFT_KEY = "left"

SplashScreen = love.graphics.newImage("pics/startScreen.png")

function love.load()
    LOCATION = "menu"
    FRAME = SplashScreen
end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(FRAME, 0, 0)
end

function love.keypressed(key)
    t = DIRECTION or "null"
    if LOCATION == "menu" then
        Bedroom:enter()

    elseif LOCATION == Bedroom.name then
        Bedroom:navigate(key)
    end

    love.window.setTitle(tostring(t ..key ) )
end