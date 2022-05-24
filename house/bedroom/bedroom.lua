local Room = require "house.room"
local Bedroom = Class {
    __includes = Room
}
local northeastPrompt

function Bedroom:init()
    Room.init(self, "bedroom", 2, 2, {
        ["e.2.2.a"] = require("house.bedroom.nightstand")(),
        ["e.2.2"] = require("house.bedroom.window")(),
        ["s.2.1"] = require("house.bedroom.dresser")(),
        ["s.1.1"] = require("house.bedroom.closet")(),
        ["n.1.2"] = require("house.bedroom.pictures")(),
        ["w.1.2"] = require("house.bedroom.hall")(),
        ["n.2.2"] = require("house.bedroom.bathroom")()
    }, {"n.2.1", "s.2.2"})
    northeastPrompt = require("house.flashingprompt")("A", 328, 148, 0.01)
end

function Bedroom:enter()
    System.setTitle("Bedroom")
    if Player.playWakeup then
        Player.playWakeup = false
        GameState.push(require "house.bedroom.wakeup")
    end
end

local northeastRoutine = function()
    local d, x, y = Player:getPosition()
    northeastPrompt.on = d == "e" and x == 2 and y == 2
    northeastPrompt:routine()
end

function Bedroom:draw()
    Room.draw(self)
    northeastRoutine()
end

--- Asset navigator script
--     local k = love.keyboard
--     if k.isDown("a") then
--         if k.isDown(Controls.right) then
--             asset.x = asset.x + 1
--         elseif k.isDown(Controls.left) and asset.x > 0 then
--             asset.x = asset.x - 1
--         elseif k.isDown(Controls.up)  and asset.y > 0 then
--             asset.y = asset.y - 1
--         elseif k.isDown(Controls.down) then
--             asset.y = asset.y + 1
--         end
--         print(asset.x .. ", " .. asset.y)
--         return
--     end

return Bedroom
