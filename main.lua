local popups = require "elements.popups"
COIN = require "elements.coin"


function love.load()
    popups:load()
    COIN:load()
end

function love.update(dt)
    popups:update(dt)
    COIN:update(dt)
end

function love.draw()
    COIN:draw()
    popups:draw()
end

