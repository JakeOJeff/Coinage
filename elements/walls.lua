local walls = {}
local sW, sH = love.graphics.getDimensions()

function walls:load()
    table.insert(walls, OBJECT:newRect(world, 0, 0, sW, 1, "static", 0, false, "block"))
    table.insert(walls, OBJECT:newRect(world, 0, sH, sW, 1, "static", 0, false, "block"))
    table.insert(walls, OBJECT:newRect(world, sW, 0, 1, sH, "static", 0, false, "block"))
    table.insert(walls, OBJECT:newRect(world, 0, 0, 1, sH, "static", 0, false, "block"))
end

return walls
