local bgImg
local view =
    Scene(
    "bedroom.2.2.e",
    {
        autoEnter = true,
        windowOpen = false,
        bgImgPath = "assets/images/bedroom/x2y2_e_bedroom.png"
    }
)

function view:init()
end

function view:draw()
    bgImg = System.graphics.createImage(self.bgImgPath)
    System.draw(bgImg, 0, 0, 0, WINDOW.scale, WINDOW.scale)
    -- System.graphics.setFont(Fonts.pixel[30])
    -- System.graphics.print("Scene " .. self.id, 0, 0)
end

function view:wheelmoved(x, y)
    print("wheelmoved", x, y)
    if not self.windowOpen then
        self.windowOpen = true
        self.bgImgPath = "assets/images/bedroom/window_open_bedroom.png"
    end
end

return view
