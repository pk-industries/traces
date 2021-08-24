--closet one (bedroom closet)

Gfx = love.graphics
ClosetOne = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
ClosetOne.entered = true

function ClosetOne:load()
    ClosetOneWall1, ClosetOneWall2 = Gfx.newImage("pics/ClosetOneWall1.png"), Gfx.newImage("pics/ClosetOneWall2.png")
    ClosetOneWalls = {ClosetOneWall1, ClosetOneWall2}
    CurrentWall = ClosetOneWall1

    
    function love.keypressed(key)
        if CurrentWall == ClosetOneWall1 then
           if key == "down" then
             --TODO: exit closetOne
          elseif key == "right" then
             CurrentWall = ClosetOneWall2
          end
     elseif CurrentWall == ClosetOneWall2 then
           if key == "left" then
               CurrentWall = ClosetOneWall1
            end
        end
    end
end

function ClosetOne:draw()
    Gfx.draw(CurrentWall, 0, 0)
end