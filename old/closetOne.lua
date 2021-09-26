ClosetOne = {}
-- by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
ClosetOne.entered = false

function ClosetOne:load()
    ClosetOneWall1, ClosetOneWall2 = Gfx.newImage(
                                         "pics/closetOne/ClosetOneWall1.png"),
                                     Gfx.newImage(
                                         "pics/closetOne/ClosetOneWall2.png")
    CurrentFrame = ClosetOneWall1
end

function ClosetOne:update()
    function love.keypressed(key)
        if CurrentFrame == ClosetOneWall1 then
            if key == "down" then
                Bedroom.entered = true
                ClosetOne.entered = false
                if Bedroom.entered then
                    Bedroom:load()
                    CurrentFrame = DresserWall
                end
            elseif key == "right" then
                CurrentFrame = ClosetOneWall2
            end
        elseif CurrentFrame == ClosetOneWall2 then
            if key == "left" then CurrentFrame = ClosetOneWall1 end
        end
    end
end

function ClosetOne:draw() Gfx.draw(CurrentFrame, 0, 0) end
