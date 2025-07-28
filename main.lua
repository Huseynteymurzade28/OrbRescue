local love = require("love")
local enemy = require("Enemy")
local Player = require("Player")
local button = require("Button")
math.randomseed(os.time())

local game = {
    difficulty = 1,
    state = {
        menu = true,
        paused = false,
        running = false,
        gameover = false,
    }
}

local player = Player() 

local buttons = {
    menu_state = {}
}

local enemies = {}

function love.load()
    love.mouse.setVisible(false)
    love.graphics.setDefaultFilter("nearest", "nearest")

    buttons.menu_state.play_game = button("Play Game", nil, nil, 200, 50)
    buttons.menu_state.settings = button("Settings", nil, nil, 200, 50)
    buttons.menu_state.exit_game = button("Quit Game", love.event.quit, nil, 200, 50)

    table.insert(enemies, 1, enemy())

end

function love.mousepressed(x, y, button)
    if not game.state.running then
        if button == 1 then
            if game.state.menu then
                for index in pairs(buttons.menu_state) do
                    buttons.menu_state[index]:on_mouse_pressed(x, y, button)
                end 
            end
        end
    end
end

function love.update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()
    player:move(mouse_x, mouse_y)
    
    for i = 1, #enemies do
        enemies[i]:move(player.x, player.y)
    end
end

function love.draw()
    love.graphics.setColor(108/255,56/255,245/255)
    love.graphics.print("FPS: "..love.timer.getFPS(), love.graphics.newFont(18), love.graphics.getWidth() - 100, love.graphics.getHeight() - 35)
    
    if game.state.running then
        for i = 1, #enemies do
            enemies[i]:draw()
        end
        player:draw()
    elseif game.state.menu then
        buttons.menu_state.play_game:draw(love.graphics.getWidth() / 2 - buttons.menu_state.settings.width / 2, love.graphics.getHeight() / 2 - 60)
        buttons.menu_state.settings:draw(love.graphics.getWidth() / 2 - buttons.menu_state.settings.width / 2, love.graphics.getHeight() / 2 + 15)
        buttons.menu_state.exit_game:draw(love.graphics.getWidth() / 2 - buttons.menu_state.exit_game.width / 2, love.graphics.getHeight() / 2 + 90)
    end

    if not game.state.running then
        DrawShip(player.x, player.y, 24)
    end
end

function DrawShip(x, y, size)
    local bodyW = size * 0.6
    local bodyH = size
    local wingW = size * 0.8
    local wingH = size * 0.4

    love.graphics.push()
    love.graphics.translate(x, y)


    love.graphics.setColor(45/255,225/255,145/255)
    love.graphics.polygon("fill",
        0, -bodyH / 2,         
        -bodyW / 2, bodyH / 2, 
        bodyW / 2, bodyH / 2   
    )

    love.graphics.setColor(108/255,56/255,245/255)
    love.graphics.polygon("fill",
        -bodyW / 2, bodyH / 2,                  
        -wingW / 2, bodyH / 2 + wingH,         
        -bodyW / 4, bodyH / 2                   
    )

    love.graphics.polygon("fill",
        bodyW / 2, bodyH / 2,                   
        wingW / 2, bodyH / 2 + wingH,           
        bodyW / 4, bodyH / 2                   
    )


    love.graphics.setColor(1, 0.5, 0)
    love.graphics.polygon("fill",
        -bodyW / 4, bodyH / 2,       
        0, bodyH / 2 + 10,           
        bodyW / 4, bodyH / 2        
    )

    love.graphics.pop()
end
