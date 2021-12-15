local Scene =
    Class {
    _includes = Saveable,
    init = function(self, id, args)
        self.id = id
        pcall(
            function()
                if args then
                    for k, v in pairs(args) do
                        self[k] = v
                    end
                end
            end
        )

        if self.save == true then
            Saveable.init(self, id)
            Saveable.load(self)
        end
    end,
    enter = function(self)
        print("Entering scene " .. self.id)
    end,
    update = function(self, dt)
    end,
    draw = function(self)
        love.graphics.setFont(Fonts.pixel[30])
        love.graphics.print("Scene " .. self.id, 0, 0)
    end,
    exit = function(self)
        print("Exiting scene " .. self.id)
    end
}

return Scene
