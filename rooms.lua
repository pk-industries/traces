local Radio =
    Child(
    "radio",
    "e",
    2,
    2,
    {
        init = function(self)
            self.active = false
            print("Radio:init()")
        end,
        draw = function()
        end,
        keypressed = function(self, key)
            if key == Controls.back then
                GameState.pop()
            end
        end
    }
)

local House = {
    bedroom = Bedroom
}

return House
