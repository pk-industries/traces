local Room = require "house.room"
local Bedroom = Class { __includes = Room }
local prompt
local promptCoor

function Bedroom:init()
    Room.init(
        self, "bedroom", 2, 2, {
            ["e.2.2.a"] = require("house.bedroom.nightstand")(),
            ["e.2.2"] = require("house.bedroom.window")(),
            ["s.2.1"] = require("house.bedroom.dresser")(),
            ["s.1.1.a"] = require("house.bedroom.sticky")(),
            ["s.1.1"] = require("house.bedroom.closet")(),
            ["n.1.2"] = require("house.bedroom.pictures")(),
            ["w.1.2"] = require("house.bedroom.hall")(),
            ["n.2.2"] = require("house.bedroom.bathroom")()
        }, { "n.2.1", "s.2.2" }
    )
    prompt = require("house.overlays.flashingprompt")("A", 328, 148)

    local promptPoint = function(text, x, y, dir, posX, posY)
        return {
            ["data"] = coordinates(text, x, y),
            ["pos"] = coordinates(dir, posX, posY)
        }
    end

    promptCoor = {
        promptPoint("A", 328, 148, "e", 2, 2), promptPoint("A", 260, 90, "s", 1, 1)
    }
end

function Bedroom:enter()
    System.setTitle("Bedroom")
    if Player.playWakeup then
        Player.playWakeup = false
        GameState.push(require "house.bedroom.wakeup")
    else
        Fade.fadeIn()
    end
end

local promptRoutine = function()
    local d, x, y = Player:getPosition()
    local matched = false
    for _, coor in pairs(promptCoor) do
        if d == coor.pos.d and x == coor.pos.x and y == coor.pos.y then
            prompt.text = coor.data.d
            prompt.x = coor.data.x
            prompt.y = coor.data.y
            matched = true
            break
        end
    end
    prompt.on = matched
    prompt:routine()
end

function Bedroom:draw()
    Room.draw(self)
    promptRoutine()
end

--- Asset navigator script
-- function Bedroom:update()
--     local asset = promptCoor[2].data
--     local k = love.keyboard
--     if k.isDown("r") then
--         if k.isDown(Controls.right) then
--             asset.x = asset.x + 1
--         elseif k.isDown(Controls.left) and asset.x > 0 then
--             asset.x = asset.x - 1
--         elseif k.isDown(Controls.up) and asset.y > 0 then
--             asset.y = asset.y - 1
--         elseif k.isDown(Controls.down) then
--             asset.y = asset.y + 1
--         end
--         print(asset.x .. ", " .. asset.y)
--         return
--     end
-- end

return Bedroom
