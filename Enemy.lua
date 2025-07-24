local love = require("love")

function Enemy()
    return {
        level = 1,
        radiues = 20,
        x = -10,
        y = -50,
        
        move = function (self, player_x, player_y)   
            if player_x > self.x then
                self.x = self.x + self.level
            elseif player_x < self.x then
                self.x = self.x - self.level
            end
        end
    }
end
