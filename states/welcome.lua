local Menus = require "utils.menus"

local welcome = {}

-- Menus
require("utils.menus")
---@type table<number, Menu>
local menulist = {Menus.Mainmenu, Menus.OptionsMenu, Menus.NewGameMenu, Menus.PauseMenu}

for i, v in ipairs(menulist) do
    v:setColorNormal(Colors.black)
    v:setColorSelected(Colors.black)
end

local function menuposition()
    local menux = love.graphics.getWidth() * .72
    local menuy = love.graphics.getHeight() * .65
    return menux, menuy
end

function welcome:enter()
    love.graphics.setBackgroundColor(Colors.white)
    MenuEngine.disable()
    Menus.Mainmenu:setDisabled(false)
end

function welcome:update(dt)
    MenuEngine.update()
end

function welcome:leave()
    MenuEngine.disable()
end

local scale = CONFIG.window.scale

function welcome:draw()
    local x, y = menuposition()
    if scale == 1 then
        for _, v in ipairs(menulist) do
            v:setFont(Fonts.pixel[16])
        end
    elseif scale == 2 then
        for _, v in ipairs(menulist) do
            v:setFont(Fonts.pixel[28])
        end
    elseif scale == 3 then
        for _, v in ipairs(menulist) do
            v:setFont(Fonts.pixel[40])
        end
    end

    for _, v in ipairs(menulist) do
        v:movePosition(x, y)
    end

    MenuEngine.draw()

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
end

function welcome:keypressed(key, scancode, isrepeat)
    if scancode == "escape" then
        love.event.quit()
    end
    MenuEngine.keypressed(scancode)
end

return welcome
