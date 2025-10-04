local popups = require "elements.popups"


function love.load()
    popups:load()
end

function love.update(dt)
    popups:update(dt)
end

function love.draw()
    popups:draw()
end

