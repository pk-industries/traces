local image, animation
local btnSnd

local StartSceen = {}

function StartSceen:init()
    -- Load Graphics
    image = System.graphics.createImage("assets/images/startscreen.png")
    local height = System.graphics.getImageHeight(image)
    local width = System.graphics.getImageWidth(image)
    local grid = Anim8.newGrid(width / 3, height, width, height)
    animation = Anim8.newAnimation(grid("1-3", 1), 0.15)
    System.graphics.setBackgroundColor(Colors.white)

    -- Load Audio
    btnSnd = System.audio.createSource("assets/sounds/button_press.wav", "static")
end

function StartSceen:enter()
end

function StartSceen:update(dt)
    animation:update(dt)
end

function StartSceen:leave()
end

function StartSceen.buttonPosition()
    local btnx = System.graphics.getWidth() * .72
    local btny = System.graphics.getHeight() * .65
    local textx, texty = btnx + 15, btny + 3
    return btnx, btny, textx, texty
end

function StartSceen:draw()
    local bx, by, px, py = StartSceen.buttonPosition()

    local startbutton = System.graphics.createImage("assets/images/button.png")
    animation:draw(image, 0, 0, 0, WINDOW.scale, WINDOW.scale)
    System.graphics.draw(startbutton, bx, by, 0, WINDOW.scale, WINDOW.scale)

    System.graphics.setFont(Fonts.pixel[20])
    System.graphics.setColor(0, 0, 0) -- black
    System.graphics.print("Start", px, py, 0, WINDOW.scale, WINDOW.scale)
    System.graphics.setColor(1, 1, 1) -- white
end

function StartSceen:keypressed(key)
    if key == Controls.a then
        System.audio.play(btnSnd)
        GameState.switch(States.game)
    elseif key == Controls.b then
        System.event.quit()
    end
end

return StartSceen
