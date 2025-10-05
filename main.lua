local popups = require "elements.popups"
COIN = require "elements.coin"

font = love.graphics.newFont(45)
inputCoins = 0

OBJECT = require "elements.object"
Coins = {}
Objects = {}
world = love.physics.newWorld(0, 9.81 * 64, false)

ScreenWalls = require "elements.walls"
clickCursor = love.mouse.getSystemCursor( "hand" )
normalCursor = love.mouse.getSystemCursor( "arrow" )




function love.load()
    popups:load()
    ScreenWalls:load()
    -- Images
    tipBacker = love.graphics.newImage("assets/tip-backer.png")
    tipFronter = love.graphics.newImage("assets/tip-fronter.png")

    preRoll = love.graphics.newImage("assets/pre-roll.png")
    Roll = love.graphics.newImage("assets/roll.png")
    currentRollImg = preRoll

    roller = {
        x = love.graphics.getWidth() - 345,
        y = love.graphics.getHeight() - 210,
        width = 25,
        height = 50
    }

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
            c.body:destroy()       -- destroy the physics body
            table.remove(Coins, i) -- remove from table
        end
    end

    local mx, my = love.mouse.getPosition()
    if inRollPos(mx, my) and not popups.enabled then
        love.mouse.setCursor(clickCursor)
    else
        love.mouse.setCursor(normalCursor)
    end
end

function love.mousepressed(x, y, button)
    for _, coin in ipairs(Coins) do
        coin:mousepressed(x, y, button)
    end
    if inRollPos(x, y) and inputCoins > 0 and  not popups.enabled then
        inputCoins = inputCoins - 1
        popups.enabled = true
        -- popups:addItems()
        currentRollImg = Roll
        print(currentRollImg)
    end
end

function love.mousereleased()
    for _, coin in ipairs(Coins) do
        coin:mousereleased()
    end
    if currentRollImg == Roll then
        currentRollImg = preRoll
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

    local scaledDownProp = 1 / 3
    love.graphics.draw(tipBacker, 10, love.graphics.getHeight() - (tipBacker:getHeight() * scaledDownProp), 0,
        scaledDownProp, scaledDownProp)
    for _, coin in ipairs(Coins) do
        coin:draw()
    end
    love.graphics.draw(tipFronter, 10, love.graphics.getHeight() - (tipBacker:getHeight() * scaledDownProp), 0,
        scaledDownProp, scaledDownProp)

    scaledDownProp = 1 / 2.15
    love.graphics.draw(currentRollImg, love.graphics.getWidth() - currentRollImg:getWidth() * scaledDownProp,
        love.graphics.getHeight() - currentRollImg:getHeight() * scaledDownProp, 0, scaledDownProp, scaledDownProp)

    love.graphics.setFont(font)
    love.graphics.print(inputCoins, love.graphics.getWidth() - 210 - font:getWidth(tostring(inputCoins)) / 2, 65)

    love.graphics.rectangle("line", roller.x, roller.y, roller.width, roller.height)
    popups:draw()
end

function inRollPos(mx, my)
    if mx > roller.x and mx < roller.x + roller.width and my > roller.y and my < roller.y + roller.width then
        return true
    end
    return false
end
