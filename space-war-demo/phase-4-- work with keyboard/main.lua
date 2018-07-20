function love.load()
	x = 0
end

function love.update(dt)
	if love.keyboard.isDown("right") then 
		x = x + 1
	end
end

function love.draw()
	love.graphics.rectangle("fill",x,10,100,50)
end


--[[ Exercise-1: 
		Do the same for all four directions.
		up, down, left, right

		hint: elseif love.keyboard.isDown(key)

		Solution: check exercise folder.
]]