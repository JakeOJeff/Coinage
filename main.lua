local popups = require "elements.popups"
COIN = require "elements.coin"

font = love.graphics.newFont(45)
inputCoins = 20

OBJECT = require "elements.object"
Coins = {}
Objects = {}
world = love.physics.newWorld(0, 9.81 * 64, false)

ScreenWalls = require "elements.walls"




function love.load()
    popups:load()
    ScreenWalls:load()
    -- Images 
    tipBacker = love.graphics.newImage("assets/tip-backer.png")
    tipFronter = love.graphics.newImage("assets/tip-fronter.png")

    preRoll = love.graphics.newImage("assets/pre-roll.png")
    roll = love.graphics.newImage("assets/roll.png")
    currentRollImg = preRoll

    objectsLoad()
    table.insert(Coins, COIN:new(world, 200, 200))

end
world:setCallbacks(beginContact)

function love.update(dt)
    world:update(dt)
    popups:update(dt)
    for _, coin in ipairs(Coins) do
        coin:update(dt)
    end
        for i = #Coins, 1, -1 do
        local c = Coins[i]
        if c.toRemove then
            c.body:destroy()  -- destroy the physics body
            table.remove(Coins, i)  -- remove from table
        end
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

function love.keypressed(key)
    if key == "e" then
           local randLoveNum = love.math.random(20, 400)
           table.insert(Coins, COIN:new(world, randLoveNum, 200))
 
    end
end

function love.draw()
    love.graphics.setBackgroundColor(89 / 255, 209 / 255, 249 / 255)
    for _, v in pairs(Objects) do
        v:draw()
    end

    local scaledDownProp = 1/3
    love.graphics.draw(tipBacker, 10, love.graphics.getHeight() - (tipBacker:getHeight() * scaledDownProp), 0, scaledDownProp, scaledDownProp )
    for _, coin in ipairs(Coins) do
        coin:draw()
    end
    love.graphics.draw(tipFronter, 10, love.graphics.getHeight() - (tipBacker:getHeight() * scaledDownProp), 0, scaledDownProp, scaledDownProp)

    scaledDownProp = 1/2.15
    love.graphics.draw(currentRollImg, love.graphics.getWidth() - currentRollImg:getWidth() * scaledDownProp, love.graphics.getHeight() - currentRollImg:getHeight() * scaledDownProp, 0, scaledDownProp, scaledDownProp)
    
    love.graphics.setFont(font)
    love.graphics.print(inputCoins, love.graphics.getWidth() - 210 - font:getWidth(tostring(inputCoins))/2, 65)
    popups:draw()
end
