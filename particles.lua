particles = {}

function particles.load()
  local circle = love.graphics.newImage("img/circle.png")

  -- constant player emmission
  playerEmit = love.graphics.newParticleSystem(circle,32)
  playerEmit:setParticleLifetime(2, 3)
	playerEmit:setEmissionRate(50)
	playerEmit:setSizeVariation(1)
	playerEmit:setLinearAcceleration(-20, -20, 20, 20)
	playerEmit:setColors(255, 255, 255, 255, 255, 255, 255, 0)
end

function particles.update(dt)
  playerEmit:update(dt)
end

function particles.draw()
  love.graphics.setColor(rP,gP,bP)
  love.graphics.draw(playerEmit, player.x,player.y)
end
