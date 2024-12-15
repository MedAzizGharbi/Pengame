local bullet = {}
bullet.list = {}

function bullet.spawn(x, y, angle, speed)
	-- Offset the spawn position so the bullet appears in front of the player
	local offsetX = math.cos(angle) * 20 -- 20 units in front of the player
	local offsetY = math.sin(angle) * 20
	table.insert(bullet.list, {
		x = x + offsetX,
		y = y + offsetY,
		angle = angle,
		speed = speed,
		radius = 8,
	})
end

function bullet.update(dt)
	for i = #bullet.list, 1, -1 do
		local b = bullet.list[i]
		-- Move the bullet
		b.x = b.x + math.cos(b.angle) * b.speed * dt
		b.y = b.y + math.sin(b.angle) * b.speed * dt
		-- Remove bullet if it goes out of bounds
		if b.x < 0 or b.x > love.graphics.getWidth() or b.y < 0 or b.y > love.graphics.getHeight() then
			table.remove(bullet.list, i)
		end
	end
end

function bullet.draw()
	for _, b in pairs(bullet.list) do
		love.graphics.circle("fill", b.x, b.y, b.radius)
	end
end

return bullet
