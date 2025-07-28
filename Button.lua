local love = require("love")

function Button(text, func, func_param, width, height)
    return {
        width = width or 100,
        height = height or 100,
        func = func or function ()
            print("This button has no function assigned.")
        end,
        func_param = func_param,
        text = text or "Button",
        button_x = 0,
        button_y = 0,
        text_x = 0,
        text_y = 0,
        pressed = false,

        is_hovered = function(self, mx, my)
            return mx >= self.button_x and mx <= self.button_x + self.width and
                   my >= self.button_y and my <= self.button_y + self.height
        end,

        on_mouse_pressed = function(self, mx, my, button)
            if self:is_hovered(mx, my) and button == 1 then
                self.pressed = true
                if self.func then
                    if self.func_param then
                        self.func(self.func_param)
                    else
                        self.func()
                    end
                end
            end
        end,
        

        draw = function(self, button_x, button_y, text_x, text_y)
            self.button_x = button_x or self.button_x
            self.button_y = button_y or self.button_y
            self.text_x = text_x or self.button_x
            self.text_y = text_y or self.button_y

            local border_radius = 10
            local shadow_offset = 4

            
            local mx, my = love.mouse.getPosition()
            local hovered = self:is_hovered(mx, my)

           
            local r, g, b = 0.3, 0.6, 0.9

            if hovered then
                r = r + 0.1
                g = g + 0.1
                b = b + 0.1
            end

           
            love.graphics.setColor(0, 0, 0, 0.3)
            love.graphics.rectangle("fill", self.button_x + shadow_offset, self.button_y + shadow_offset, self.width, self.height, border_radius, border_radius)

            
            love.graphics.setColor(r, g, b)
            love.graphics.rectangle("fill", self.button_x, self.button_y, self.width, self.height, border_radius, border_radius)

            
            love.graphics.setColor(r * 0.8, g * 0.8, b * 0.8)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", self.button_x, self.button_y, self.width, self.height, border_radius, border_radius)

            
            love.graphics.setColor(1, 1, 1)
            local font = love.graphics.getFont()
            local textWidth = font:getWidth(self.text)
            local textHeight = font:getHeight()
            local text_x_centered = self.button_x + (self.width - textWidth) / 2
            local text_y_centered = self.button_y + (self.height - textHeight) / 2
            love.graphics.print(self.text, text_x_centered, text_y_centered)

            love.graphics.setColor(1, 1, 1)
        end
    }
end

return Button
