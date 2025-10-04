local coin = {}

function coin:load(world)
    self.x = x
    self.y = y
    self.xVel = 0
    self.yVel = 0
    self.img = love.graphics.newImage("assets/ball.png")
 
    self.body = love.physics.newBody(world, self.width/2)
end

return coin