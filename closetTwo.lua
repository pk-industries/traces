ClosetTwo = {}
-- by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
ClosetTwo.entered = false

function ClosetTwo:load()
    ClosetTwo_Y = 0
    ClosetTwoImage = Gfx.newImage("pics/closetTwo/closetTwo.png")
    CurrentFrame = ClosetTwoImage
end

-- TODO: If crank is  turning, then play the animation. Else, stop in the loop.
-- We will probably want a list of PNGs, and to start on one PNG (the eye level one when we first open the closet)
-- From there, we can loop the list, and draw the next index in the list on each rotary position of the crank.

function ClosetTwo:update(dt)
    function love.keypressed(key)
        if key == "down" then ClosetTwo_Y = ClosetTwo_Y - 5 end
    end
end

function ClosetTwo:draw() Gfx.draw(CurrentFrame, 0, ClosetTwo_Y) end
