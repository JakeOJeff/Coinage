local object = {}
object.__index = object

function object:newRect(world, x, y, width, height, type)
    local self = setmetatable({}, object)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.type = type

    self.body = love.physics.newBody(world, self.x, self.y, self.type)
    self.shape = love.physics.newRectangleShape(self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    return self
end

return object