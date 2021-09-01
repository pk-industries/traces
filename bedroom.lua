--5  views (towards living room door, towards bathroom, towards bed, towards closet, towards desk), state of closet door, desk, 

Gfx = love.graphics
Bedroom = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
Bedroom.entered = false

function Bedroom:load()

    HallWall, BathWall, DresserWall, BedWall = Gfx.newImage("pics/HallWall.png"), Gfx.newImage("pics/BathWall.png"), Gfx.newImage("pics/DresserWall.png"), Gfx.newImage("pics/BedWall.png")
    BedroomWalls = {HallWall, BathWall, DresserWall, BedWall}
    CurrentFrame = HallWall

    function love.keypressed(key)

        if CurrentFrame == HallWall then
           if key == "left" then
            CurrentFrame = DresserWall
           elseif key == "right" then
            CurrentFrame = BathWall

           --use "space" to set Hallway.entered to true, then load the Hallway.
           elseif key == "space" then
            --TODO: AND if padlock is opened
            Hallway.entered = true
            Bedroom.entered = false
            if Hallway.entered then
                Hallway:load()
            end
           end

        elseif CurrentFrame == DresserWall then
           if key == "left" then
            CurrentFrame = BedWall
           elseif key == "right" then
            CurrentFrame = HallWall
           elseif key == "up" then
            MusicBox.entered = true
            --enter the music box
            if MusicBox.entered then
                MusicBox:load()
            end
           end

        elseif CurrentFrame == BedWall then
            if key == "left" then
             CurrentFrame = BathWall
            elseif key == "right" then
             CurrentFrame = DresserWall
            end

        elseif CurrentFrame == BathWall then
            if key == "left" then
             CurrentFrame = HallWall
            elseif key == "right" then
             CurrentFrame = BedWall
            end

        end
    end

end



function Bedroom:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end