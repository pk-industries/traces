local game = {}

function game:init()
    local status, data = pcall(Player.load, Player)

    if not status then
        print("Error in player load " .. data)
    else
        print("Game init complete.")
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