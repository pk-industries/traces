local welcome = {}
-- Menus
require("utils.menus")

local function menuposition()
    local menux = love.graphics.getWidth() * .75
    local menuy = love.graphics.getHeight() * .65
    return menux, menuy
end

function welcome:enter()
    love.graphics.setBackgroundColor(Colors.white)
    MenuEngine.disable()
    mainmenu:setDisabled(false)
    local x, y = menuposition()
    print(x, y)
    mainmenu:movePosition(x, y)
    options:movePosition(x, y)
    new_game:movePosition(x, y)
    pausemenu:movePosition(x, y)
end

function welcome:update(dt)
    MenuEngine.update()
end

function welcome:leave()
    MenuEngine.disable()
end

function welcome:draw()
    local house = love.graphics.newImage("assets/images/house.png")
    love.graphics.draw(house, love.graphics.getWidth() * -.1, 0, 0, CONFIG.window.scale, CONFIG.window.scale)
    local traces = love.graphics.newImage("assets/images/traces.png")
    love.graphics.draw(
        traces,
        love.graphics.getWidth() * .75,
        love.graphics.getWidth() * .05,
        0,
        CONFIG.window.scale,
        CONFIG.window.scale
    )

    MenuEngine.draw()
end

function welcome:keypressed(key, scancode, isrepeat)
    if scancode == "escape" then
        love.event.quit()
    end
    MenuEngine.keypressed(scancode)
end

function welcome:mousemoved(x, y, dx, dy, istouch)
    MenuEngine.mousemoved(x, y)
end
return welcome
