function love.load()
	x = 0
end

function love.update(dt)
	x = x + 1
end

function love.draw()
	love.graphics.rectangle("fill",x,10,100,50)
end