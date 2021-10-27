local welcome = {}
-- Menus
local menus = require("utils.menus")
local mainmenu, pos = menus.mainmenu, menus.pos

function welcome:enter()
    love.graphics.setBackgroundColor(Colors.white)
    MenuEngine.disable()
    mainmenu:setDisabled(false)
end

function welcome:update(dt)
    MenuEngine.update()
end

function welcome:leave()
    MenuEngine.disable()
end

function welcome:draw()
    local frame = love.graphics.newImage("assets/images/house.png")
    love.graphics.draw(frame, -15, 0)
    love.graphics.draw(love.graphics.newImage("assets/images/traces.png"), pos.x, 10)
    MenuEngine.draw()
end

function welcome:keypressed(key, scancode, isrepeat)
    MenuEngine.keypressed(scancode)

    if scancode == "escape" then
        love.event.quit()
    end
end

function welcome:mousemoved(x, y, dx, dy, istouch)
    MenuEngine.mousemoved(x, y)
end
return welcome
