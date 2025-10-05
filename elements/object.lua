local object = {}
object.__index = object

function object:newRect(world, x, y, width, height, type, angle)
    local self = setmetatable({}, object)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.type = type
    self.angle = angle or 0

    self.body = love.physics.newBody(world, self.x, self.y, self.type)
    self.shape = love.physics.newRectangleShape(self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.body:setAngle(self.angle)

    return self
end

function object:draw()
    love.graphics.push()
    love.graphics.translate(self.body:getX(), self.body:getY())
    love.graphics.rotate(self.body:getAngle())
    love.graphics.rectangle("line", -self.width/2, -self.height/2, self.width, self.height)
    love.graphics.pop()
end




return object