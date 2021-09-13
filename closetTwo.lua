ClosetTwo = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
ClosetTwo.entered = false

function ClosetTwo:load()
    --This could be a good chance for an animation, e.g. moving downwards from eye level. This closet will probably just be one wall.
    --CurrentFrame = CurrentFrame
end

--TODO: If crank is  turning, then play the animation. Else, stop in the loop.
--We will probably want a list of PNGs, and to start on one PNG (the eye level one when we first open the closet)
--From there, we can loop the list, and draw the next index in the list on each rotary position of the crank.

function ClosetTwo:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end