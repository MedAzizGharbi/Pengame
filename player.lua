local player = {}
local bullet = require("bullet")

-- Player variables
player.x, player.y, player.w, player.h = 20, 20, 40, 40
player.angle = 0
player.speed = 200
player.isCircle = false -- Player starts as a rectangle
player.screenW, player.screenH = love.graphics.getDimensions()

-- Time tracking for shooting
local timeSinceLastShot = 0
local shootCooldown = 0.2

function player.load()
	love.window.setMode(800, 600, { fullscreen = false, vsync = true })
end

-- Player update function
function player.update(dt)
	-- Player movement (same for both circle and rectangle)
	if love.keyboard.isDown("up") and player.y > 0 then
		player.y = player.y - player.speed * dt
	end
	if love.keyboard.isDown("down") and player.y < player.screenH - player.h then
		player.y = player.y + player.speed * dt
	end
	if love.keyboard.isDown("left") and player.x > 0 then
		player.x = player.x - player.speed * dt
	end
	if love.keyboard.isDown("right") and player.x < player.screenW - player.w then
		player.x = player.x + player.speed * dt
	end

	-- Check if the player has entered the lake's area and toggle shape
	local lakeX, lakeY, lakeRadius = 400, 300, 50 -- Lake's position and radius
	local distToLake = math.sqrt((player.x + player.w / 2 - lakeX) ^ 2 + (player.y + player.h / 2 - lakeY) ^ 2)

	-- If player enters the lake area (within the circle) toggle shape
	if distToLake < lakeRadius + player.w / 2 then
		player.isCircle = true -- Change to circle when in the lake
	else
		player.isCircle = false -- Change back to rectangle when out of the lake
	end

	-- Calculate angle to face the mouse (used for rectangle)
	local mouseX, mouseY = love.mouse.getPosition()
	player.angle = math.atan2(mouseY - (player.y + player.h / 2), mouseX - (player.x + player.w / 2))

	-- Handle shooting (only possible when player is not a circle)
	if love.keyboard.isDown("a") and timeSinceLastShot >= shootCooldown and not player.isCircle then
		bullet.spawn(player.x, player.y, player.angle, 300)
		timeSinceLastShot = 0
	end

	timeSinceLastShot = timeSinceLastShot + dt -- Update time since last shot
end

-- Player draw function
function player.draw()
	if player.isCircle then
		-- Draw player as a circle
		love.graphics.push()
		love.graphics.setColor(255, 0, 0) -- Red color for the circle
		love.graphics.circle("fill", player.x + player.w / 2, player.y + player.h / 2, player.w / 2)
		love.graphics.pop()
	else
		-- Draw player as a rectangle
		love.graphics.push()
		love.graphics.translate(player.x + player.w / 2, player.y + player.h / 2)
		love.graphics.rotate(player.angle)
		love.graphics.rectangle("fill", -player.w / 2, -player.h / 2, player.w, player.h)
		love.graphics.pop()
	end
end

return player
