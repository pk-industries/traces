--5  views (towards living room door, towards bathroom, towards bed, towards closet, towards desk), state of closet door, desk, 

Gfx = love.graphics
Bedroom = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
Bedroom.entered = true

function Bedroom:load()

    HallWall, BathWall, DresserWall, BedWall = Gfx.newImage("pics/HallWall.png"), Gfx.newImage("pics/BathWall.png"), Gfx.newImage("pics/DresserWall.png"), Gfx.newImage("pics/BedWall.png")
    BedroomWalls = {HallWall, BathWall, DresserWall, BedWall}
    CurrentWall = HallWall

    function love.keypressed(key)

        if CurrentWall == HallWall then
           if key == "left" then
            CurrentWall = DresserWall
           elseif key == "right" then
            CurrentWall = BathWall

           --use "space" to set Hallway.entered to true, then load the Hallway.
           elseif key == "space" then
            --TODO: AND if padlock is opened
            Hallway.entered = true
            Bedroom.entered = false

            if Hallway.entered then
                Hallway:load()
            end

           end

        elseif CurrentWall == DresserWall then
           if key == "left" then
            CurrentWall = BedWall
           elseif key == "right" then
            CurrentWall = HallWall
           end

        elseif CurrentWall == BedWall then
            if key == "left" then
             CurrentWall = BathWall
            elseif key == "right" then
             CurrentWall = DresserWall
            end

        elseif CurrentWall == BathWall then
            if key == "left" then
             CurrentWall = HallWall
            elseif key == "right" then
             CurrentWall = BedWall
            end

        end
    end

end

function Bedroom:draw()
    Gfx.draw(CurrentWall, 0, 0)
end