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
    love.graphics.rectangle("line", -self.width / 2, -self.height / 2, self.width, self.height)
    love.graphics.pop()
end

function objectsLoad()
    local midCenter = love.graphics.getWidth() / 2
    local midWidth = love.graphics.getWidth() / 5

    table.insert(Objects, OBJECT:newRect(world, midCenter - 125, 200, midWidth, 10, "static", 0.3))

    table.insert(Objects, OBJECT:newRect(world, midCenter + midWidth / 2 + 130, 0.8 * 400, 10, 10, "static", -0.5))
    table.insert(Objects, OBJECT:newRect(world, midCenter + 125, 400, midWidth, 10, "static", -0.3))

    table.insert(Objects, OBJECT:newRect(world, midCenter - midWidth / 2 - 130, 0.8 * 600, 10, 10, "static", 0.5))
    table.insert(Objects, OBJECT:newRect(world, midCenter - 125, 600, midWidth, 10, "static", 0.3))
end

return object
