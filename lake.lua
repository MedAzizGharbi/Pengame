local lake = {}

function lake.draw()
	-- Set color to cyan (R, G, B values for cyan)
	love.graphics.setColor(0, 255, 255) -- Cyan color (RGB)

	-- Draw the circle at position (400, 300) with a radius of 100
	love.graphics.circle("fill", 400, 300, 50) -- x, y, radius
end

return lake
