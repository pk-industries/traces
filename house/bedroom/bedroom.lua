local Scene = require "libs.scene"

Bedroom = {
    id = "bedroom",
    width = 2,
    height = 2,
    views = {},
    scenes = {
        ["e.2.2"] = require "house.bedroom.radio",
        ["s.2.1"] = require "house.bedroom.dresser",
        ["s.1.1"] = Scene("bedroom.closet"),
        ["w.1.2"] = Scene("hallway"),
        ["n.2.2"] = Scene("bedroom.bathoom")
    },
    obsticals = {
        ["2.1"] = "2.2",
        ["2.2"] = "2.1"
    }
}

local color
function Bedroom:init()
end
function Bedroom:enter()
    color = Colors.black
    Timer.tween(2, color, Colors.white, "linear")

    love.window.setTitle(GameState.current().id)
    Signal.emit("player.position-check")
end
function Bedroom:update(dt)
    Timer.update(dt)
end
function Bedroom:draw()
    love.graphics.setColor(color)
    local d, x, y = Player:getPosition()
    local assetsdir = "assets/images/"
    local roomdir = assetsdir .. GameState:current().id .. "/" --- /assets/images/bedroom/
    local filename = "x" .. x .. "y" .. y .. "_" .. d .. "_" .. self.id .. ".png"

    local filepath = roomdir .. filename
    local scale = CONFIG.window.scale

    if FileExists(filepath) then
        love.graphics.draw(love.graphics.newImage(filepath), 0, 0, 0, scale, scale)
    else
        error("File: " .. filepath .. " does not exist")
    end

    --

    local stats = {
        id = GameState.current().id,
        direction = d,
        x = x,
        y = y
    }
    if type(Player.scene) == "table" then
        stats.scene = Player.scene.id
    end
    love.graphics.setColor(Colors.white)
    love.graphics.rectangle("fill", 0, 0, 225, 225)
    love.graphics.setColor(Colors.red)
    love.graphics.setFont(Fonts.monospace[20])
    love.graphics.print(Inspect(stats), 10, 10)
    love.graphics.setColor(Colors.white)
end

function Bedroom:keypressed(key)
    if Controls.arrowkeys[key] then
        Player:move(key)
    end

    if key == Controls.enter and Player.scene then
        print(Player.scene.id)
        GameState.push(Player.scene)
    end
end

function Bedroom:leave()
end
