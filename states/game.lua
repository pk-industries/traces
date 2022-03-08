local game = {}

function game:init()
    print("\nCreating player...")
    local status, data = pcall(require "states.player", "player")

    if not status then
        print("Error in game:init(): " .. data)
    else
        print("game:init()")
        print("Player is " .. tostring(data))
        Player = data
        data:load()
        print("Game init done")
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