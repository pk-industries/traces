--Holds bathroom state, 2 walls(shower and sink walls??)

Gfx = love.graphics
Bathroom = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
Bathroom.entered = false

function Bathroom:load()
    BathWall1, BathWall2, SinkWall = Gfx.newImage("pics/BathWall1.png"), Gfx.newImage("pics/BathWall2.png"), Gfx.newImage("pics/SinkWall.png")
    BathWalls = {BathWall1, BathWall2, SinkWall}
    CurrentWall = BathWall1
end

function love.keypressed(key)
    if CurrentWall == BathWall1 then
        if key == "up" then
            CurrentWall = SinkWall
        elseif key == "down" then
            --TODO: ENTER BACK INTO BEDROOM
        end
    elseif CurrentWall == SinkWall then
        if key == "left" then
            CurrentWall = BathWall2
        elseif key == "down" then
            CurrentWall = BathWall1
        end
    elseif CurrentWall == BathWall2 then
        if key == "right" then
            CurrentWall = SinkWall
        --TODO: DO SHOWER WALL STUFF
        end
    end
end


function Bathroom:draw()
    Gfx.draw(CurrentWall, 0, 0)
end