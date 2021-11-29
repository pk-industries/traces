local image, animation

local StartSceen = {}

function StartSceen:init()
    image = love.graphics.newImage("assets/images/startscreen.png")
    local g = Anim8.newGrid(image:getWidth() / 3, image:getHeight(), image:getWidth(), image:getHeight())
    animation = Anim8.newAnimation(g("1-3", 1), 0.15)
    love.graphics.setBackgroundColor(Colors.white)
end

function StartSceen:enter()
end

function StartSceen:update(dt)
    animation:update(dt)
end

function StartSceen:leave()
end

function StartSceen.buttonPosition()
    local btnx = love.graphics.getWidth() * .72
    local btny = love.graphics.getHeight() * .65
    local textx, texty = btnx + 15, btny + 3
    return btnx, btny, textx, texty
end

function StartSceen:draw()
    local bx, by, px, py = StartSceen.buttonPosition()

    local startbutton = love.graphics.newImage("assets/images/button.png")
    animation:draw(image, 0, 0, 0, WINDOW.scale, WINDOW.scale)
    love.graphics.draw(startbutton, bx, by, 0, WINDOW.scale, WINDOW.scale)

    love.graphics.setFont(Fonts.pixel[20])
    love.graphics.setColor(0, 0, 0) -- black
    love.graphics.print("Start", px, py, 0, WINDOW.scale, WINDOW.scale)
    love.graphics.setColor(1, 1, 1) -- white
end

function StartSceen:keypressed(key, scancode, isrepeat)
    if key == Controls.enter then
        GameState.switch(States.game)
    elseif key == Controls.back then
        love.event.quit()
    end
end

return StartSceen
