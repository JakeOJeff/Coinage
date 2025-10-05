local popups = {}



function popups:load()
    headerFont = love.graphics.newFont(50)
    wW = love.graphics.getWidth()
    wH = love.graphics.getHeight()
    self.enabled = true
end

function popups:update(dt)

end

function popups:draw()
    if self.enabled then
        love.graphics.setColor(0, 0, 0, 0.7)

        love.graphics.rectangle("fill", 50, 50, wW - 100, wH - 100, 25, 25)
        love.graphics.setFont(headerFont)
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.print("YOU HAVE EARNED", 50 + (wW - 100) / 2 - headerFont:getWidth("YOU HAVE EARNED") / 2, 100)
    end
    love.graphics.setColor(1, 1, 1)
end

return popups
