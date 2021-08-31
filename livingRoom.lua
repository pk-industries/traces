--Holds living room state, 4 walls, (state of kitchen light?)

Gfx = love.graphics
LivingRoom = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
LivingRoom.entered = false

function LivingRoom:load()
    MainWall1, MainWall2, MainWall3, MainWall4 = Gfx.newImage("pics/mainWall1.png"), Gfx.newImage("pics/mainWall2.png"), Gfx.newImage("pics/mainWall3.png"), Gfx.newImage("pics/mainWall4.png")
    MainWalls = {MainWall1, MainWall2, MainWall3, MainWall4}
    CurrentFrame = MainWall1

    function love.keypressed(key)
        if CurrentFrame == MainWall1 then
            if key == "right" then
                CurrentFrame = MainWall2
            elseif key == "left" then
                CurrentFrame = MainWall4
            end
        elseif CurrentFrame == MainWall2 then
            if key == "right" then
                CurrentFrame = MainWall3
            elseif key == "left" then
                CurrentFrame = MainWall1
            end
        elseif CurrentFrame == MainWall3 then
            if key == "right" then
                CurrentFrame = MainWall4
            elseif key == "left" then
                CurrentFrame = MainWall2
            end
        elseif CurrentFrame == MainWall4 then
            if key == "right" then
                CurrentFrame = MainWall1
            elseif key == "left" then
                CurrentFrame = MainWall3
            end
        end
    end

end



function LivingRoom:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end