local coin = {}
coin.__index = coin

function coin:new(world, x, y)
    local self = setmetatable({}, coin)

    self.x = x
    self.y = y
    self.xVel = 0
    self.yVel = 0
    self.mox = 0
    self.moy = 0
    self.img = love.graphics.newImage("assets/coin.png")

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newCircleShape(self.img:getWidth() / 8)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)


    self.fixture:setRestitution(1)


    self.dragging = false

    return self
end

function coin:update(dt)
    self.x, self.y = self.body:getPosition()
    self.xVel, self.yVel = self.body:getLinearVelocity()
    if self.dragging and self.mouseJoint then
        local mx, my = love.mouse.getPosition()
        self.mouseJoint:setTarget(mx, my)
    end

    print(self.dragging)
end

function coin:draw()
    love.graphics.draw(self.img, self.x, self.y, self.body:getAngle(), self.shape:getRadius() * 2 / self.img:getWidth(),
        self.shape:getRadius() * 2 / self.img:getHeight(), self.img:getWidth() / 2, self.img:getHeight() / 2)
end

function coin:mousepressed(x, y, button)
    if self:inRad(x, y, self.x, self.y, self.shape:getRadius()) and button == 1 and not self.dragging then
        self.dragging = true
        self.mox = x - self.x
        self.moy = y - self.y
        self.mouseJoint = love.physics.newMouseJoint(self.body, x, y)
    end
end

function coin:mousereleased()
    if self.dragging then
        self.dragging = false
        if self.mouseJoint then
            self.mouseJoint:destroy()
            self.mouseJoint = nil
        end
    end
end

function coin:inRad(x1, y1, x2, y2, radius)
    local dist = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
    return dist <= radius
end

return coin
