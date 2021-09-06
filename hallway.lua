
Gfx = love.graphics

Hallway = {}
--entered set to true upon entering the hallway
Hallway.entered = false

function Hallway:load()

    HallLivingWall, HallBackWall, HallFrontWall, HallBedWall, FuseBox, HallBackWall2, HallFrontWall2, HallFrontWall3 = Gfx.newImage("pics/hall/HallLivingWall.png"), Gfx.newImage("pics/hall/HallBackWall.png"), Gfx.newImage("pics/hall/HallFrontWall.png"), Gfx.newImage("pics/hall/HallBedWall.png"), Gfx.newImage("pics/hall/FuseBox.png"), Gfx.newImage("pics/hall/HallBackWall2.png"), Gfx.newImage("pics/hall/HallFrontWall2.png"), Gfx.newImage("pics/hall/HallFrontWall3.png")
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
            elseif key == "up" then
                CurrentFrame = HallFrontWall2
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
        elseif CurrentFrame == HallFrontWall2 then
            if key == "up" then
                CurrentFrame = HallFrontWall3
            end
        elseif CurrentFrame == HallFrontWall3 then
            if key == "left" then 
                CurrentFrame = FuseBox
            elseif key == "right" then
                LivingRoom.entered = true
                Hallway.entered = false
                if LivingRoom.entered then
                    LivingRoom:load()
                    CurrentFrame = LivingFrontWall
                end
            end
        elseif CurrentFrame == FuseBox then
            if key == "right" then
                CurrentFrame = HallFrontWall3
            elseif key == "left" then
                CurrentFrame = HallBackWall2
            end
        elseif CurrentFrame == HallBackWall2 then
            if key == "right" then
                CurrentFrame = FuseBox
            elseif key == "up" then
                CurrentFrame = HallBackWall
            end
        end
    end

end

function Hallway:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end