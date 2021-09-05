--Holds bathroom state, 2 walls(shower and sink walls??)

Gfx = love.graphics
Bathroom = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
Bathroom.entered = false

function Bathroom:load()
    BathWall1, BathWall2, SinkWall = Gfx.newImage("pics/bathroom/BathWall1.png"), Gfx.newImage("pics/bathroom/BathWall2.png"), Gfx.newImage("pics/bathroom/SinkWall.png")
    BathWalls = {BathWall1, BathWall2, SinkWall}
    CurrentFrame = BathWall1

    function love.keypressed(key)
        if CurrentFrame == BathWall1 then
            if key == "up" then
                CurrentFrame = SinkWall
            elseif key == "down" then
                Bedroom.entered = true
                if Bedroom.entered then
                    Bedroom:load()
                    CurrentFrame = BathWall
                end
            end
        elseif CurrentFrame == SinkWall then
            if key == "left" then
                CurrentFrame = BathWall2
            elseif key == "down" then
                CurrentFrame = BathWall1
            end
        elseif CurrentFrame == BathWall2 then
            if key == "right" then
                CurrentFrame = SinkWall
            --TODO: DO SHOWER WALL STUFF
            end
        end
    end
    
end



function Bathroom:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end