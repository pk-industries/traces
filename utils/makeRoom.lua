local Tile = Class{
    init = function(self, x, y, type)
        self.x = x
        self.y = y
        self.type = type
    end
}

local Room = Class{
    init = function(self, name, width, height)
        self.name = name
        self.width = width
        self.height = height
        self.tiles = {}
        for y = 1, height do
            table.insert(self.tiles, {})
            for x = 1, width do
                table.insert(self.tiles[y], Tile(x, y, 1))
            end
        end
    end
}

return Room,Class
