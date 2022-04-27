local scenes = require "house.scenetemplates"
local HorizontalExplorer = scenes.HorizontalExplorer
local Closet = Class { __includes = HorizontalExplorer }

function Closet:init()
    HorizontalExplorer.init(self, "bedroom.closet", "s", 1, 1, true, "assets/images/bedroom/bedroom_closet.png")
end

function Closet:enter()
    self.img.x = (WINDOW.baseW * 2)
end

function Closet:keypressed(key)
    if key == GamePad.up and self.img.x == 0 then
        Player.direction = "n"
        GameState.pop()
    elseif key == GamePad.down and self.img.x == (WINDOW.baseW * 2) then
        Player.direction = "s"
        GameState.pop()
    end
    HorizontalExplorer.keypressed(self, key)
end

return Closet
