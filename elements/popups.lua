local popups = {}



function popups:load()
    headerFont = love.graphics.newFont(50)
    itemFont = love.graphics.newFont(25)
    wW = love.graphics.getWidth()
    wH = love.graphics.getHeight()
    self.enabled = false
    self.timer = 0
    self.itemInventory = {}

    self.itemList = {
        {
            name = "Coins",
            quantity = 1,
            img = love.graphics.newImage("assets/coin.png"),
            func = function()
                table.insert(Coins, COIN:new(world, love.math.random(10, 350), 200))
            end,
            rarity = 1 / 2
        },
        {
            name = "Orpheus",
            quantity = 1,
            img = love.graphics.newImage("assets/orpheus.png"),
            func = function()
                self:addItemToInv("Orpheus")
            end,
            rarity = 1 / 4
        },
        {
            name = "Red Gumball",
            quantity = 1,
            img = love.graphics.newImage("assets/gumball.png"),
            func = function ()
                                self:addItemToInv("Red Gumball")

            end,
            color = {1,0,0},
            rarity = 1/25
        },
        {
            name = "Green Gumball",
            quantity = 1,
            img = love.graphics.newImage("assets/gumball.png"),
            func = function ()
                                self:addItemToInv("Green Gumball")

            end,
            color = {0,1,0},
            rarity = 1/12
        },
        {
            name = "Blue Gumball",
            quantity = 1,
            img = love.graphics.newImage("assets/gumball.png"),
            func = function ()
                                self:addItemToInv("Blue Gumball")

            end,
            color = {0,0,1},
            rarity = 1/8
        },
    }
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

function popups:addItemToInv(n)
    local exists = false

    for _, item in ipairs(self.itemInventory) do
        if item.name == n then
            item.quantity = item.quantity + 1
            exists = true
            break
        end
    end

    if not exists then
        table.insert(self.itemInventory, { name = n, quantity = 1 })
    end
end

function popups:update(dt)
    if self.enabled then
        self.timer = self.timer + dt
    end

    local flooredTimer = math.floor(self.timer)
    if (flooredTimer == 1 or flooredTimer == 2 or flooredTimer == 3)
        and self.lastTrigger ~= flooredTimer then

        self.lastTrigger = flooredTimer
        self:addItems()
    end

    if flooredTimer == 6  and self.enabled then
        self.enabled = false

        for _, v in ipairs(self.slabs) do
            for i = 1, v.quantity do
                v.func()
            end
        end
        

        self.timer = 0
        self.slabs = {}
        self.lastTrigger = nil
    end
end

function popups:addItems()
    local chosenItem = pickRandomItem(self.itemList)
    local addQty = love.math.random(1, 3)

    -- Check if the item already exists in slabs
    local found = false
    for _, slab in ipairs(self.slabs) do
        if slab.name == chosenItem.name then
            slab.quantity = slab.quantity + addQty
            found = true
            break
        end
    end

    -- If not found, add a new entry
    if not found then
        local newItem = {
            name = chosenItem.name,
            quantity = addQty,
            img = chosenItem.img,
            func = chosenItem.func,
            rarity = chosenItem.rarity,
            color = chosenItem.color
        }
        table.insert(self.slabs, newItem)
    end
end

function pickRandomItem(itemList)
    local totalWeight = 0
    for _, item in ipairs(itemList) do
        totalWeight = totalWeight + item.rarity
    end

    local random = love.math.random() * totalWeight
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

            if self.slabs[i].color then
                love.graphics.setColor(self.slabs[i].color)
            end
            love.graphics.draw(
                img,
                x + w / 2,
                y + w / 2,
                0,
                scale, scale,
                imgW / 2, imgH / 2
            )
            love.graphics.setColor(1,1,1,0.7)
            love.graphics.setFont(itemFont)
            love.graphics.print(self.slabs[i].name .. " x" .. self.slabs[i].quantity,
                x + w / 2 - itemFont:getWidth(self.slabs[i].name .. " x" .. self.slabs[i].quantity) / 2, y + w / 2 + 100)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return popups
