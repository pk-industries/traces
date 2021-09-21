Kitchen = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
Kitchen.entered = false

function Kitchen:load()
    KitchenSink, KitchenCabinet, KitchenLaundryDoor, KitchenLivingWall, KitchenBackWall, KitchenTable, KitchenFarLaundry = Gfx.newImage("pics/kitchen/KitchenSink.png"), Gfx.newImage("pics/kitchen/KitchenCabinet.png"), Gfx.newImage("pics/kitchen/KitchenLaundryDoor.png"), Gfx.newImage("pics/kitchen/KitchenLivingWall.png"), Gfx.newImage("pics/kitchen/KitchenBackWall.png"), Gfx.newImage("pics/kitchen/KitchenTable.png"), Gfx.newImage("pics/kitchen/KitchenFarLaundry.png")
    CurrentFrame = KitchenSink
end

function Kitchen:update()

    function love.keypressed(key)
        if CurrentFrame == KitchenSink then
            if key == "right" then
                CurrentFrame = KitchenFarLaundry
            elseif key == "left" then
                CurrentFrame = KitchenTable
            elseif key == "down" then
                Kitchen.entered = false
                LivingRoom.entered = true
                if LivingRoom.entered then
                    LivingRoom:load()
                end
            end
        elseif CurrentFrame == KitchenCabinet then
            if key == "right" then
                CurrentFrame = KitchenLaundryDoor
            elseif key == "left" then
                CurrentFrame = KitchenBackWall
            end
        elseif CurrentFrame == KitchenLaundryDoor then
            if key == "right" then
                CurrentFrame = KitchenLivingWall
            elseif key == "left" then
                CurrentFrame = KitchenCabinet
            elseif key == "down" then
                CurrentFrame = KitchenFarLaundry
            end
        elseif CurrentFrame == KitchenLivingWall then
            if key == "right" then
                CurrentFrame = KitchenBackWall
            elseif key == "left" then
                CurrentFrame = KitchenLaundryDoor
            end
        elseif CurrentFrame == KitchenBackWall then
            if key == "right" then
                CurrentFrame = KitchenCabinet
            elseif key == "left" then
                CurrentFrame = KitchenLivingWall
            elseif key == "up" then
                CurrentFrame = KitchenTable
            end
        elseif CurrentFrame == KitchenTable then
            if key == "right" then
                CurrentFrame = KitchenSink
            elseif key == "down" then
                CurrentFrame = KitchenBackWall
            elseif key == "left" then
                Kitchen.entered = false
                LivingRoom.entered = true
                if LivingRoom.entered then
                    LivingRoom:load()
                end
            end
        elseif CurrentFrame == KitchenFarLaundry then
            if key == "right" then
                Kitchen.entered = false
                LivingRoom.entered = true
                if LivingRoom.entered then
                    LivingRoom:load()
                end
            elseif key == "left" then
                CurrentFrame = KitchenSink
            elseif key == "up" then
                CurrentFrame = KitchenLaundryDoor
            end
        end
    end

end

function Kitchen:draw()
    Gfx.draw(CurrentFrame, 0, 0)
end