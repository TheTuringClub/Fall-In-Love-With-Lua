function love.load()
	--player table
	player = {}
	player.x = 0
	player.bullets = {}
	player.fire = function()
		bullet = {}
		bullet.x = player.x
		bullet.y = 400
		table.insert(player.bullets, bullet)
	end
end

function love.update(dt)
	if love.keyboard.isDown("right") then 
		player.x = player.x + 1
	elseif love.keyboard.isDown("left") then
		player.x = player.x - 1
	end
	--player.fire() called
	if love.keyboard.isDown("space") then 
		player.fire()
	end
end

function love.draw()
	--player color
	love.graphics.setColor(0, 0, 255)

	--player
	love.graphics.rectangle("fill",player.x,400,50,50)

	--bullet color
	love.graphics.setColor(255,255,255)

	--fire bullet
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	end
end