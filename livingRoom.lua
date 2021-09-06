--Holds living room state, 4 walls, (state of kitchen light?)

Gfx = love.graphics
LivingRoom = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
LivingRoom.entered = false

function LivingRoom:load()
    LivingFrontWall, LivingKitchenWall, LivingBackWall, LivingHallWall, Calendar, FrontDoorLock, KitchenEntrance, RecordPlayer = Gfx.newImage("pics/livingRoom/LivingFrontWall.png"), Gfx.newImage("pics/livingRoom/LivingKitchenWall.png"), Gfx.newImage("pics/livingRoom/LivingBackWall.png"), Gfx.newImage("pics/livingRoom/LivingHallWall.png"), Gfx.newImage("pics/livingRoom/Calendar.png"), Gfx.newImage("pics/livingRoom/FrontDoorLock.png"), Gfx.newImage("pics/livingRoom/KitchenEntrance.png"), Gfx.newImage("pics/livingRoom/RecordPlayer.png")
    LivingWalls = {LivingFrontWall, LivingKitchenWall, LivingBackWall, LivingHallWall, Calendar, FrontDoorLock, KitchenEntrance, RecordPlayer}
    CurrentFrame = LivingFrontWall

    function love.keypressed(key)
        if CurrentFrame == LivingFrontWall then
            if key == "right" then
                CurrentFrame = LivingKitchenWall
            elseif key == "left" then
                CurrentFrame = LivingHallWall
            elseif key == "up" then
                CurrentFrame = FrontDoorLock
            end
        elseif CurrentFrame == FrontDoorLock then
            if key == "down" then
                CurrentFrame = LivingFrontWall
            end
        elseif CurrentFrame == LivingKitchenWall then
            if key == "right" then
                CurrentFrame = LivingBackWall
            elseif key == "left" then
                CurrentFrame = LivingFrontWall
            elseif key == "space" then
                CurrentFrame = KitchenEntrance
            elseif key == "up" then
                CurrentFrame = Calendar
            end
        elseif CurrentFrame == KitchenEntrance then
            if key == "down" then
                CurrentFrame = LivingKitchenWall
            end
        elseif CurrentFrame == Calendar then
            if key == "down" then
                CurrentFrame = LivingKitchenWall
            end
        elseif CurrentFrame == LivingBackWall then
            if key == "right" then
                CurrentFrame = LivingHallWall
            elseif key == "left" then
                CurrentFrame = LivingKitchenWall
            elseif key == "up" then
                CurrentFrame = RecordPlayer
            end
        elseif CurrentFrame == RecordPlayer then
            if key == "down" then
                CurrentFrame = LivingBackWall
            end
        elseif CurrentFrame == LivingHallWall then
            if key == "right" then
                CurrentFrame = LivingFrontWall
            elseif key == "left" then
                CurrentFrame = LivingBackWall
            elseif key == "space" then
                Hallway.entered = true
                LivingRoom.entered = false
                if Hallway.entered then
                    Hallway:load()
                    CurrentFrame = FuseBox
                end
            end
        end
    end

end



function LivingRoom:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end