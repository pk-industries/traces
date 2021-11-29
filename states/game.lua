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

    for i in ipairs(self.sound) do
        local sound = self.sound[i]
        self.sound[i].audio = love.audio.newSource(sound.filePath, sound.type)
    end

    GameState.switch(House[Player.room])
end
function game:leave()
    self.save(self)
end
function game:resume()
end
function game:update(dt)
end
function game:draw()
end

return game
