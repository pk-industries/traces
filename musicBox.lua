Gfx = love.graphics
MusicBox = {}
MusicBox.entered = false

function MusicBox:load()

    MusicBoxMain, SelectorMark = Gfx.newImage("pics/bedroom/MusicBox.png"), Gfx.newImage("pics/SelectorMark.png")
    
    function love.keypressed(key)
        --if you press the keys in the right order....bb^v<>aba
        --then music box animates and music plays when you turn the crank
        --and it opens up and reveals padlock code
        
        --else key pressed order == anything else
        --then music box does bad animation, spookyMusic1 = spookyMusic2
    end


end

function MusicBox:draw()
    Gfx.draw(MusicBoxMain, 0, 0)
    Gfx.draw(SelectorMark, 200, 100)
end