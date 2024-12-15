local player = require("player")
local bullet = require("bullet")
local lake = require("lake")
local game = {}

function game.load()
	player.load()
end

function game.update(dt)
	player.update(dt)
	bullet.update(dt)
end

function game.draw()
	lake.draw()
	player.draw()
	bullet.draw()
end

return game
