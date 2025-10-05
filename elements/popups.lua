local popups = {}



function popups:load()
    headerFont = love.graphics.newFont(50)
    itemFont = love.graphics.newFont(25)
    wW = love.graphics.getWidth()
    wH = love.graphics.getHeight()
    self.enabled = false
    self.itemList = {
        {
            name = "Coins",
            quantity = 1,
            img = love.graphics.newImage("assets/coin.png"),
            func = function()
                table.insert(Coins, COIN:new(200, 200))
            end,
            rarity = 1 / 2
        },
        {
            name = "Orpheus",
            quantity = 1,
            img = love.graphics.newImage("assets/orpheus.png"),
            func = function()
                
            end,
            rarity = 1 / 4
        },
    }
    self.itemInventory = {}
    self.slabs = {}
    --[[
    {
        name = "Coins",
        quantity = 3,
        img = love.graphics.newImage("assets/coin.png"),
        func = function()
            table.insert(Coins, COIN:new(200, 200))
        end
    } ]]
end

function popups:update(dt)

end

function popups:addItems()
    local chosenItem = pickRandomItem(self.itemList)
    chosenItem.quantity = love.math.random(1, 3)
    table.insert(self.slabs, chosenItem)
end
function pickRandomItem(itemList)
    local totalWeight = 0
    for _, item in ipairs(itemList) do
        totalWeight = totalWeight + item.rarity
    end

    local random = math.random() * totalWeight
    local current = 0

    for _, item in ipairs(itemList) do
        current = current + item.rarity
        if random <= current then
            return item
        end
    end
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
            love.graphics.rectangle("line", x, wH / 2 - w / 2, w, w, 25, 25)
            local img = self.slabs[i].img
            local imgW, imgH = img:getWidth(), img:getHeight()
            local scale = (w * 0.7) / imgW

            local y = 220

            love.graphics.draw(
                img,
                x + w / 2,
                y + w / 2,
                0,
                scale, scale,
                imgW / 2, imgH / 2
            )
            love.graphics.setFont(itemFont)
            love.graphics.print(self.slabs[i].name .. " x" .. self.slabs[i].quantity,
                x + w / 2 - itemFont:getWidth(self.slabs[i].name .. " x" .. self.slabs[i].quantity) / 2, y + w / 2 + 100)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return popups
