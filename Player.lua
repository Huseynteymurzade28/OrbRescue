local love = require("love")

function Player()

    local _image = love.graphics.newImage("assets/Player.png")

    return {
        radius = 21,
        x = 30,
        y = 30,

        move = function (self, mouse_x, mouse_y)
            self.x = mouse_x
            self.y = mouse_y
        end,

        draw = function (self)
            love.graphics.draw(_image, self.x - self.radius, self.y - self.radius)
        end
    }
end

return Player