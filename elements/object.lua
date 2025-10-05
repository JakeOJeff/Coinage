local object = {}
object.__index = object

function object:newRect(world, x, y, width, height, type, angle, visible, id)
    local self = setmetatable({}, object)
    self.x = x + width / 2
    self.y = y + height / 2
    self.width = width
    self.height = height
    self.type = type
    self.angle = angle or 0
    self.visible = visible
    self.id = id or "block"

    self.body = love.physics.newBody(world, self.x, self.y, self.type)
    self.shape = love.physics.newRectangleShape(self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.body:setAngle(self.angle)

    return self
end

function object:newHollowCircle(world, x, y, outerRadius, innerRadius, type, visible, id)
    local self = setmetatable({}, object)
    self.x = x
    self.y = y
    self.outerRadius = outerRadius
    self.innerRadius = innerRadius
    self.type = type
    self.visible = visible
    self.id = id or "hollowCircle"

    self.body = love.physics.newBody(world, self.x, self.y, self.type)
    self.outerShape = love.physics.newCircleShape(self.outerRadius)
    self.outerFixture = love.physics.newFixture(self.body, self.outerShape)
    self.outerFixture:setUserData(self)

    self.innerShape = love.physics.newCircleShape(self.innerRadius)
    self.innerFixture = love.physics.newFixture(self.body, self.innerShape)
    self.innerFixture:setSensor(true)
    self.innerFixture:setUserData({ parent = self, id = "inner" })

    return self
end

function object:draw()
    love.graphics.push()
    if self.visible then
        love.graphics.translate(self.body:getX(), self.body:getY())
        love.graphics.rotate(self.body:getAngle())

        -- Hollow circle visualization
        if self.outerShape and self.innerShape then
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("line", 0, 0, self.outerRadius)
            love.graphics.circle("line", 0, 0, self.innerRadius)
        elseif self.shape and self.shape:typeOf("CircleShape") then
            love.graphics.circle("line", 0, 0, self.shape:getRadius())
        elseif self.shape and self.shape:typeOf("PolygonShape") then
            love.graphics.rectangle("line", -self.width / 2, -self.height / 2, self.width, self.height)
        end
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
end


function beginContact(fixtureA, fixtureB, contact)
    local objA = fixtureA:getUserData()
    local objB = fixtureB:getUserData()

    if objA and objB then
        if (objA.id == "coin" and objB.id == "slot") or (objB.id == "coin" and objA.id == "slot") then
            inputCoins = inputCoins + 1

            -- Mark coin for removal
            if objA.id == "coin" then
                objA.toRemove = true
            elseif objB.id == "coin" then
                objB.toRemove = true
            end
        end
    end
end

function objectsLoad()
    local midCenter = love.graphics.getWidth() / 2
    local midWidth = love.graphics.getWidth() / 5

    -- table.insert(Objects, OBJECT:newRect(world, midCenter - 125, 200, midWidth, 10, "static", 0.3, true))

    -- table.insert(Objects, OBJECT:newRect(world, midCenter + midWidth / 2 + 130, 0.8 * 400, 10, 10, "static", -0.5, true))
    -- table.insert(Objects, OBJECT:newRect(world, midCenter + 125, 400, midWidth, 10, "static", -0.3, true))

    -- table.insert(Objects, OBJECT:newRect(world, midCenter - midWidth / 2 - 130, 0.8 * 600, 10, 10, "static", 0.5, true))
    -- table.insert(Objects, OBJECT:newRect(world, midCenter - 125, 600, midWidth, 10, "static", 0.3, true))

    

    table.insert(Objects,
        OBJECT:newRect(world, 10, 30 + love.graphics.getHeight() - (tipBacker:getHeight() * 1 / 3), 2,
            tipBacker:getHeight() * 1 / 3, "static", 0, false))
    table.insert(Objects,
        OBJECT:newRect(world, 10 + (tipBacker:getWidth() * 1 / 3),
            30 + love.graphics.getHeight() - (tipBacker:getHeight() * 1 / 3), 2, tipBacker:getHeight() * 1 / 3,
            "static", 0, false))

            local smallPropSize = 1/2.15

    table.insert(Objects, OBJECT:newRect(world, love.graphics.getWidth() - currentRollImg:getWidth() * smallPropSize + 245, 380, 10, 200, "static", 0.235, false ))
    table.insert(Objects, OBJECT:newRect(world, love.graphics.getWidth() - currentRollImg:getWidth() * smallPropSize + 175, love.graphics.getHeight() - 145, 100, 5, "static", 0, false ))
        table.insert(Objects, OBJECT:newRect(world, love.graphics.getWidth() - currentRollImg:getWidth() * smallPropSize + 175, love.graphics.getHeight() - 70, 100, 5, "static", 0, false ))


        -- slot
        table.insert(Objects, OBJECT:newRect(world, love.graphics.getWidth() - currentRollImg:getWidth() * smallPropSize + 275, love.graphics.getHeight() - 145, 10, 80, "static", 0, false, "slot"))
        table.insert(Objects, OBJECT:newRect(world, love.graphics.getWidth() - currentRollImg:getWidth() * smallPropSize + 235, 0, 10, 130, "static", 0, false))

    end

return object
