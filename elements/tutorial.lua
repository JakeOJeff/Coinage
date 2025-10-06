local tutorial = {}


function tutorial:load()
    self.list = {
        {
            info = "Press 'E' to spawn a Coin",
            x = 200,
            y = 200,
            completed = false
        },
        {
            info = "Drag the Coin to the Slot Machine",
            x = 400,
            y = 200,
            completed = false
        }
    }

end

function tutorial:update()
    if love.keyboard.isDown("e") then
        self.list[1].completed = true
    end
end

function tutorial:draw()
    for _, v in ipairs(self.list) do
        if not v.completed then
            love.graphics.print(v.info, v.x, v.y)  
                    break

        end
    end
        
end

return tutorial