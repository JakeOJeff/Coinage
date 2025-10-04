local popups = require "elements.popups"
COIN = require "elements.coin"


function love.load()
    world = love.physics.newWorld(0, 0, true)
    popups:load()
    COIN:load(world)
end

function love.update(dt)
    world:update(dt)
    popups:update(dt)
    COIN:update(dt)
end

function love.draw()
    COIN:draw()
    popups:draw()
end

