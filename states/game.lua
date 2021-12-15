local game = {}

local House = require "house.house"
function game:init()
    local status, err =
        pcall(
        function()
            Player:init("player")
        end
    )
    if not status then
        print("Error in game:init(): " .. err)
    else
        print("game:init()")
        Player:load()
    end
end

function game:enter()
    GameState.switch(House[Player.room])
end
function game:leave()
end
function game:resume()
end
function game:update(dt)
end
function game:draw()
end

return game
