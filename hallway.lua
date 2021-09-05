
Gfx = love.graphics

Hallway = {}
--entered set to true upon entering the hallway
Hallway.entered = false

function Hallway:load()

    HallLivingWall, HallBackWall, HallFrontWall, HallBedWall = Gfx.newImage("pics/hall/HallLivingWall.png"), Gfx.newImage("pics/hall/HallBackWall.png"), Gfx.newImage("pics/hall/HallFrontWall.png"), Gfx.newImage("pics/hall/HallBedWall.png")
    HallwayWalls = {HallLivingWall, HallBackWall, HallFrontWall, HallBedWall}
    CurrentFrame = HallLivingWall

    function love.keypressed(key)
        if CurrentFrame == HallLivingWall then
            if key == "left" then
                CurrentFrame = HallFrontWall
            elseif key == "right" then
                CurrentFrame = HallBackWall
            end
        elseif CurrentFrame == HallFrontWall then
            if key == "left" then
                CurrentFrame = HallBedWall
            elseif key == "right" then
                CurrentFrame = HallLivingWall
            end
        elseif CurrentFrame == HallBedWall then
            if key == "left" then
                CurrentFrame = HallBackWall
            elseif key == "right" then
                CurrentFrame = HallFrontWall

            --check if key is space (to enter bedroom door), if so then load Bedroom    
            elseif key == "space" then
                Bedroom.entered = true
                Hallway.entered = false

                if Bedroom.entered then
                    Bedroom:load()
                    CurrentFrame = BedWall
                end

            end
        elseif CurrentFrame == HallBackWall then
            if key == "left" then
                CurrentFrame = HallLivingWall
            elseif key == "right" then
                CurrentFrame = HallBedWall
            end
        end
    end

end

function Hallway:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end