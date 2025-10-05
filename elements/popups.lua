local popups = {}



function popups:load()
    headerFont = love.graphics.newFont(50)
    wW = love.graphics.getWidth()
    wH = love.graphics.getHeight()
    self.enabled = true
    self.slabs = { {}, {} }
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

        local w = 250
        local spacing = 10
        local totalWidth = #self.slabs * (w + spacing) - spacing
        local startX = (wW / 2) - (totalWidth / 2)

        for i = 1, #self.slabs do
            local x = startX + (i - 1) * (w + spacing)
            love.graphics.rectangle("line", x, wH/2 - w/2, w, w, 25, 25)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return popups
