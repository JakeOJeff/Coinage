local popups = require "elements.popups"
COIN = require "elements.coin"
Coins = {}


function love.load()
    world = love.physics.newWorld(0, 0, true)
    popups:load()
    
    table.insert(Coins, COIN:new(world, 200, 200))
    table.insert(Coins, COIN:new(world, 400, 200))
end

function love.update(dt)
    world:update(dt)
    popups:update(dt)
    for _, coin in ipairs(Coins) do
        coin:update(dt)
    end
end

function love.mousepressed(x, y, button)
    for _, coin in ipairs(Coins) do
        coin:mousepressed(x, y, button)
    end
end

function love.mousereleased()
    for _, coin in ipairs(Coins) do
        coin:mousereleased()
    end
end

function love.draw()
    for _, coin in ipairs(Coins) do
        coin:draw()
    end
    popups:draw()
end
