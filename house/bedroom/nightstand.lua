local bgImg

local view =
    Scene(
    "bedroom.2.2.e",
    {
        autoEnter = true
    }
)

function view:init()
    bgImg = love.graphics.newImage("assets/bedroom/x2y2_e_bedroom.png")
end

function view:draw()
    love.graphics.draw(bgImg, 0, 0)
end

return view
