local game = {}

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