local image, animation

local StartSceen = {}

function StartSceen:init()
    image = System.createImage("assets/images/startscreen.png")
    local g = Anim8.newGrid(image:getWidth() / 3, image:getHeight(), image:getWidth(), image:getHeight())
    animation = Anim8.newAnimation(g("1-3", 1), 0.15)
    System.setBackgroundColor(Colors.white)
end

function StartSceen:enter()
end

function StartSceen:update(dt)
    animation:update(dt)
end

function StartSceen:leave()
end

function StartSceen.buttonPosition()
    local btnx = System.getWidth() * .72
    local btny = System.getHeight() * .65
    local textx, texty = btnx + 15, btny + 3
    return btnx, btny, textx, texty
end

function StartSceen:draw()
    local bx, by, px, py = StartSceen.buttonPosition()

    local startbutton = System.createImage("assets/images/button.png")
    animation:draw(image, 0, 0, 0, WINDOW.scale, WINDOW.scale)
    System.draw(startbutton, bx, by, 0, WINDOW.scale, WINDOW.scale)

    System.setFont(Fonts.pixel[20])
    System.setColor(0, 0, 0) -- black
    System.print("Start", px, py, 0, WINDOW.scale, WINDOW.scale)
    System.setColor(1, 1, 1) -- white
end

function StartSceen:keypressed(key, scancode, isrepeat)
    if key == Controls.a then
        GameState.switch(States.game)
    elseif key == Controls.b then
        System.event.quit()
    end
end

return StartSceen
