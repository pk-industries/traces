Gfx = love.graphics

Hallway = {}
--entered set to true upon entering the hallway
Hallway.entered = false

function Hallway:load()

    HallLivingWall, HallBackWall, HallFrontWall, HallBedWall = Gfx.newImage("pics/HallLivingWall.png"), Gfx.newImage("pics/HallBackWall.png"), Gfx.newImage("pics/HallFrontWall.png"), Gfx.newImage("pics/HallBedWall.png")
    HallwayWalls = {HallLivingWall, HallBackWall, HallFrontWall, HallBedWall}
    CurrentWall = HallLivingWall

    function love.keypressed(key)
        if CurrentWall == HallLivingWall then
            if key == "left" then
                CurrentWall = HallFrontWall
            elseif key == "right" then
                CurrentWall = HallBackWall
            end
        elseif CurrentWall == HallFrontWall then
            if key == "left" then
                CurrentWall = HallBedWall
            elseif key == "right" then
                CurrentWall = HallLivingWall
            end
        elseif CurrentWall == HallBedWall then
            if key == "left" then
                CurrentWall = HallBackWall
            elseif key == "right" then
                CurrentWall = HallFrontWall
            end
        elseif CurrentWall == HallBackWall then
            if key == "left" then
                CurrentWall = HallLivingWall
            elseif key == "right" then
                CurrentWall = HallBedWall
            end
        end
    end

end

function Hallway:draw()
    Gfx.draw(CurrentWall, 0, 0)
end