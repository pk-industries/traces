local game = Saveable("game")
game.sound = {}

local House = require "house.house"
function game:init()
    print("game:init()")
    Player:init()
    Saveable.load(self)
end

function game:enter()
    print("game:enter()")

    GameState.switch(House[Player.room])
end
function game:leave()
    Saveable.save(self)
end
function game:resume()
end
function game:update(dt)
end
function game:draw()
end

return game
