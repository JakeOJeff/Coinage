local popups = require "elements.popups"
COIN = require "elements.coin"
OBJECT = require "elements.object"
Coins = {}
    world = love.physics.newWorld(0, 9.81 * 64, false)

ScreenWalls = require "elements.walls"


function love.load()
    popups:load()
    ScreenWalls:load()
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
    love.graphics.setBackgroundColor(89/255, 209/255, 249/255)
    for _, coin in ipairs(Coins) do
        coin:draw()
    end
    popups:draw()
end
