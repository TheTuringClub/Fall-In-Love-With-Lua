function love.load()
	--player table
	player = {}
	player.x = 0
	-- get window height
	player.y = love.graphics.getHeight()-70
	player.bullets = {}
	--player cooldown
	player.cooldown = 20
	--player speed
	player.speed = 10
	player.fire = function()
		if player.cooldown <=0 then 
			player.cooldown = 10
			bullet = {}
			-- bullet center
			bullet.x = player.x + 20 
			bullet.y = player.y
			table.insert(player.bullets, bullet)
		end
	end
end

function love.update(dt)
	--player cooldown
	player.cooldown = player.cooldown - 1

	if love.keyboard.isDown("right") then 
		player.x = player.x + player.speed
	elseif love.keyboard.isDown("left") then
		player.x = player.x - player.speed
	end
	--player.fire() called
	if love.keyboard.isDown("space") then 
		player.fire()
	end

	--move bullets
	for i,b in ipairs(player.bullets) do
		if b.y < -2 then 
			table.remove(player.bullets, i)
		end
		b.y = b.y - 10
	end
end

function love.draw()
	--player color
	love.graphics.setColor(0, 0, 255)

	--player
	love.graphics.rectangle("fill",player.x,player.y,50,50)

	--bullet color
	love.graphics.setColor(255,255,255)

	--fire bullet
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	end
end