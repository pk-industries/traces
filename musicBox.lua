MusicBox = {}
MusicBox.entered = false

function MusicBox:load()
    TextBox.entered = true
    MusicBoxMain = Gfx.newImage("pics/bedroom/MusicBox.png")
    CurrentFrame = MusicBoxMain
end

function MusicBox:update()
    function love.keypressed(key)
        if key == "down" then
            Bedroom.entered = true
            MusicBox.entered = false
            if Bedroom.entered then
                Bedroom:load()
                CurrentFrame = DresserWall
            end
        end
        --if you press the keys in the right order....bb^v<>aba
        --then music box animates and music plays when you turn the crank
        --and it opens up and reveals padlock code
        
        --else key pressed order == anything else
        --then music box does bad animation, spookyMusic1 = spookyMusic2
    end
end

function MusicBox:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end