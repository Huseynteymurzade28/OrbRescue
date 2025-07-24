local love = require("love")

local game  = {
    difficulty = 1,
    state = {
        menu = true,
        paused = false,
        running = false,
        gameover = false,
    }
}

local player = {
    radius = 20,
    x = 30,
    y = 30,
}



function love.load()
   love.window.setTitle("orbrescue")
   love.mouse.setVisible(false)
end 

function love.update(dt)
    player.x, player.y = love.mouse.getPosition()
end

function love.draw()
    love.graphics.print("FPS: "..love.timer.getFPS(), love.graphics.newFont(18), love.graphics.getWidth() - 100, love.graphics.getHeight() - 35)
    if game.state.running then
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    else
        love.graphics.circle("fill", player.x, player.y, player.radius)
    end

end