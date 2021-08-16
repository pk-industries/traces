--holds kitchen state, kitchen light, laundry room locked, cabinets, dishwasher, blinds/window

Gfx = love.graphics
Kitchen = {}
--by default, you have not "entered" the room. set to true by walking thru room door (if it is declared as true here it is only for debugging, or it is the starting room)
Kitchen.entered = false