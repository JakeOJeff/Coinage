local coin = {}

function coin:load(world)
    self.x = 200
    self.y = 200
    self.xVel = 0
    self.yVel = 0
    self.img = love.graphics.newImage("assets/coin.png")
 
    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newCircleShape(self.img:getWidth() / 5)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setRestitution(0.5)

    self.dragging = false
end

function coin:update(dt)
    self.x, self.y = self.body:getPosition()
    self.xVel, self.yVel = self.body:getLinearVelocity()

end

function coin:draw()

    love.graphics.draw(self.img, self.x, self.y, self.body:getAngle(), self.shape:getRadius() * 2 / self.img:getWidth(), self.shape:getRadius() * 2 / self.img:getHeight(), self.img:getWidth() / 2, self.img:getHeight() / 2)

end

function coin:mousepressed(x, y, button)
    if self:inRad(x, y, self.x - self.img:getWidth()/2, self.y - self.img:getHeight()/2) then
        self.dragging = true
    end
end

function coin:mousereleased()
    if self.dragging then
        self.dragging = false
    end
end

function coin:inRad(x1, y1, x2, y2)

    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end


return coin