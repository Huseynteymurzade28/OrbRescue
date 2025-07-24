local love = require("love")
local enemy = require("Enemy")
local Player = require("Player")

math.randomseed(os.time())

local game = {
    difficulty = 1,
    state = {
        menu = false,
        paused = false,
        running = true,
        gameover = false,
    }
}

local enemies = {}
local player = Player() 

function love.load()
    love.mouse.setVisible(false)
    love.graphics.setDefaultFilter("nearest", "nearest")
    table.insert(enemies, 1, enemy())
end

function love.update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()
    player:move(mouse_x, mouse_y)
    
    for i = 1, #enemies do
        enemies[i]:move(player.x, player.y)
    end
end

function love.draw()
    love.graphics.print("FPS: "..love.timer.getFPS(), love.graphics.newFont(18), love.graphics.getWidth() - 100, love.graphics.getHeight() - 35)
    
    if game.state.running then
        for i = 1, #enemies do
            enemies[i]:draw()
        end
        player:draw()
    else
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
end