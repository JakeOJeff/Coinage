local walls = {}
local sW, sH = love.graphics.getDimensions()

table.insert(walls, love.physics.newBody(world, sW / 2, 0, "static"))
walls[#walls].shape = love.physics.newRectangleShape(sW, 10)
walls[#walls].fixture = love.physics.newFixture(walls[#walls], walls[#walls].shape)

table.insert(walls, love.physics.newBody(world, sW / 2, sH, "static"))
walls[#walls].shape = love.physics.newRectangleShape(sW, 10)
walls[#walls].fixture = love.physics.newFixture(walls[#walls], walls[#walls].shape)

table.insert(walls, love.physics.newBody(world, 0, sH / 2, "static"))
walls[#walls].shape = love.physics.newRectangleShape(10, sH)
walls[#walls].fixture = love.physics.newFixture(walls[#walls], walls[#walls].shape)

table.insert(walls, love.physics.newBody(world, sW, sH / 2, "static"))
walls[#walls].shape = love.physics.newRectangleShape(10, screenHeight)
walls[#walls].fixture = love.physics.newFixture(walls[#walls], walls[#walls].shape)

return walls