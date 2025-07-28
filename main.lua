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
    },
    points = 0,
    levels = {15, 30, 45, 60, 75},
}

local player = Player() 

local buttons = {
    menu_state = {}
}

local enemies = {}

local function changeGameState(state)
    game.state.menu = state == "menu"
    game.state.running = state == "running"
    game.state.paused = state == "paused"
    game.state.gameover = state == "gameover"

end

local function startNewGame()
    changeGameState("running")

    game.points = 0

    enemies = {
        enemy(1)
    }
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

function love.load()
    love.mouse.setVisible(false)
    love.graphics.setDefaultFilter("nearest", "nearest")

    buttons.menu_state.play_game = button("Play Game", startNewGame, nil, 200, 50)
    buttons.menu_state.settings = button("Settings", nil, nil, 200, 50)
    buttons.menu_state.exit_game = button("Quit Game", love.event.quit, nil, 200, 50)

    

end


function love.update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()
    player:move(mouse_x, mouse_y)

    if game.state.running then
        for i = 1, #enemies do
            if not enemies[i]:isTouched(player.x,player.y,player.radius) then
                enemies[i]:move(player.x, player.y)
                for i = 1, #game.levels do
                    if math.floor(game.points) == game.levels[i] then
                        table.insert(enemies, 1, enemy(game.difficulty * (i + 1)))

                        game.points = game.points + 1
                    end
                end
                else
                    changeGameState("menu")
                end
            end
    
        end
        game.points = game.points + dt
    end
    


function love.draw()
    love.graphics.setColor(108/255,56/255,245/255)
    love.graphics.print("FPS: "..love.timer.getFPS(), love.graphics.newFont(18), love.graphics.getWidth() - 100, love.graphics.getHeight() - 35)
    
    if game.state.running then

        love.graphics.printf("Points: " .. math.floor(game.points), love.graphics.newFont(25), 10, 10, love.graphics.getWidth(), "left")
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
