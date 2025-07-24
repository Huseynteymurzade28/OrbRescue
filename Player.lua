local love = require("love")

function Player()
    return {
        radius = 20,
        x = 30,
        y = 30,

        move = function (self, mouse_x, mouse_y)
            self.x = mouse_x
            self.y = mouse_y
        end,

        draw = function (self)
            love.graphics.circle("fill", self.x, self.y, self.radius)
        end
    }
end

return Player