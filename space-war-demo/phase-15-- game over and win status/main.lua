-------------------------------------------------------------------------------------

--[[
	All functions
]]

--------------------------------------------------------------------------------------
--Enemy
enemies_control = {}
enemies_control.enemies = {}
--enemy image
enemies_control.image = love.graphics.newImage("graphics/enemy.png")

--enemy spawn
function enemies_control:spawnEnemy(x,y)
	enemy = {}
	enemy.x = x
	enemy.y = y
	enemy.h = self.image:getWidth()
	enemy.w = self.image:getHeight()
	enemy.bullets = {}
	enemy.cooldown = 20
	enemy.speed = 1
	table.insert(self.enemies, enemy)
end

--Enemy Fire
function enemies_control:fire()
	if enemy.cooldown <=0 then 
		enemy.cooldown = 90
		bullet = {}
		-- bullet center
		bullet.x = enemy.x + 20 
		bullet.y = enemy.y + 40
		table.insert(enemy.bullets, bullet)
	end
end

--Collision function
function checkCollisions(enemy, bullet)
	--explosion sound
	explosion_sound = love.audio.newSource("sound/explosion.mp3", "stream")
	for i,e in pairs(enemy) do
		for j,b in pairs(bullet) do
			if b.y <= e.y + e.h and b.x > e.x and b.x < e.x + e.w then
				love.audio.play(explosion_sound)
				score = score + 1
				table.remove(enemy, i)
				table.remove(bullet, j)
			end
		end
	end
end
------------------------------------------------------------------------------------------
--[[
	main Game starts fromw below
]]
------------------------------------------------------------------------------------------
-- Love Load
function love.load()
	--game status
	game_over = false
	game_won = false
	score = 0

	--background music
	local background_music = love.audio.newSource("sound/game_music.mp3", "stream")
	background_music:setLooping(true)
	love.audio.play(background_music)

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

	--Player fire sound
	player.fire_sound = love.audio.newSource("sound/laser_gun.wav", "stream")

	player.fire = function()
		love.audio.play(player.fire_sound)
		if player.cooldown <=0 then 
			player.cooldown = 10
			bullet = {}
			-- bullet center
			bullet.x = player.x + 12 
			bullet.y = player.y
			table.insert(player.bullets, bullet)
		end
	end
	
	--player image
	player.image = love.graphics.newImage("graphics/player.png")
	
	--game background image
	background_image = love.graphics.newImage("graphics/starfield.png")
	
	--enemies spawn create call
	for i=0,10 do
		enemies_control:spawnEnemy(i*75,0)
	end
end

-- Love Update
function love.update(dt)

	--player cooldown
	player.cooldown = player.cooldown - 1
	enemy.cooldown = enemy.cooldown - 1

	-- Working with player keyboard
	if love.keyboard.isDown("right") then 
		player.x = player.x + player.speed
	elseif love.keyboard.isDown("left") then
		player.x = player.x - player.speed
	--elseif love.keyboard.isDown("r") then
	--	love.event.quit("restart")
	elseif love.keyboard.isDown("escape") then
		love.event.quit()
	end

	--player.fire() called
	if love.keyboard.isDown("space") then 
		player.fire()
	end

	--move player bullets
	for i,b in ipairs(player.bullets) do
		if b.y < -2 then 
			table.remove(player.bullets, i)
		end
		b.y = b.y - 10
	end

	--Enemy.fire() called
	--for i,e in ipairs(enemies_control.enemies) do
	--enemies_control:fire()

	--move enemy bullets
	--for i,b in ipairs(enemy.bullets) do
	--	if b.y >= love.graphics.getHeight()  then 
	--		table.remove(enemy.bullets, i)
	--	end
	--	b.y = b.y + 10
	--end

	-- move enemy
	for _,e in pairs(enemies_control.enemies) do
		if e.y >= love.graphics.getHeight()-96 then
			game_over = true
		end
		e.y = e.y + enemy.speed
	end

	--check length of enemies table 
	if #enemies_control.enemies == 0 then
		game_won = true
	end 

	--call collision function
	checkCollisions(enemies_control.enemies, player.bullets)
end

-- Love Draw
function love.draw()
	--game background image
	--love.graphics.draw(background_image, 0, 0)
	for i=0, love.graphics.getWidth(), background_image:getWidth() do
		for j=0, love.graphics.getHeight(), background_image:getHeight() do
			love.graphics.draw(background_image, i, j)
		end
	end


	-- check if game over?
	if game_over then
		love.graphics.print("Game Over!",love.graphics.getWidth()/2-45,love.graphics.getHeight()/2)
		return
	elseif game_won then
		love.graphics.print("You Won",love.graphics.getWidth()/2-42,love.graphics.getHeight()/2)
	end

	--player color
	love.graphics.setColor(255, 255, 255)

	--player
	love.graphics.draw(player.image,player.x,player.y)

	--Enemies color
	love.graphics.setColor(255,255,255)

	--Enemies
	for _,e in pairs(enemies_control.enemies) do
		love.graphics.draw(enemies_control.image, e.x,e.y)
	end

	--Player bullet color
	love.graphics.setColor(255,255,255)

	--player fire bullet
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	end

	--print score
	love.graphics.print("Score: "..score, love.graphics.getWidth()/2-50, love.graphics.getHeight()-20)

	--Enemy bullet color
	--love.graphics.setColor(255,255,255)

	--Enemy fire bullet
	--for _,b in pairs(enemy.bullets) do
	--	love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	--end
end