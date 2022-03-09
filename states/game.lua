local game = {}

function game:init()
    local status, data = pcall(require "states.player", "player")

    if not status then
        print("Error in game:init(): " .. data)
    else
        Player = data
        data:load()
    end
    print("Game init complete.")
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