local coin = {}

function coin:load(world)
    self.x = x
    self.y = y
    self.xVel = 0
    self.yVel = 0
    self.img = love.graphics.newImage("assets/ball.png")
 
    self.body = love.physics.newBody(world, 100, 800, "dynamic")
    self.shape = love.physics.newCircleShape(60)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setRestitution(0.5)
end

function coin:update(dt)
    self.x, self.y = self.body:getPosition()
    self.xVel, self.yVel = self.body:getLinearVelocity()

end

function game:draw()

    

end

return coin