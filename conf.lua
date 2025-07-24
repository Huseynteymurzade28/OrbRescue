local love = require("love")

function love.conf(t)
    t.window.title = "OrbRescue"
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = false
    t.window.vsync = 1
    t.console = false

    t.modules.joystick = false
    t.modules.physics = false
end
