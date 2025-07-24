local love = require("love")

function Enemy()
    local dice = math.random(1, 4)
    local _x, _y = 0, 0
    local _radius = 20

    if dice == 1 then
        _x = math.random(0, love.graphics.getWidth())
        _y = -(_radius) * 4
    elseif dice == 2 then
        _x = -(_radius) * 4
        _y = math.random(0, love.graphics.getHeight())
    elseif dice == 3 then
        _x = math.random(0, love.graphics.getWidth())
        _y = love.graphics.getHeight() + (_radius * 4) 
    else
        _x = love.graphics.getWidth() + (_radius * 4)    
        _y = math.random(0, love.graphics.getHeight())
    end
    return {
        level = 1,
        radius = _radius,
        x = _x,
        y = _y,
        
        move = function (self, player_x, player_y)   
            if player_x > self.x then
                self.x = self.x + self.level
            elseif player_x < self.x then
                self.x = self.x - self.level
            end
            if player_y > self.y then
                self.y = self.y + self.level
            elseif player_y < self.y then
                self.y = self.y - self.level
            end
        end,

        draw = function (self)
            love.graphics.setColor(1, 0, 0) -- Set color to red
            love.graphics.circle("fill", self.x, self.y, self.radius)
            love.graphics.setColor(1, 1, 1) -- Reset color to white
        end
    }
end

return Enemy
