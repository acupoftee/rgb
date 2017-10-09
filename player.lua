player = {x=650,y=350,xVel=0,yVel=0}
bullets = {}

function player.load()
  rP = 0
  gP = 0
  bP = 0
  maxVel = 10
  minVel = -10
  bulletSpeed= 400
  rBar = 0
  gBar = 0
  bBar = 0
  cooldown = 0
  cooldownMax = .5
  isAlive = true
  status = 1
  bulletDamage = 1
end



function player.update(dt)

  rBar = (rP/255)*math.pi*2
  gBar = (gP/255)*math.pi*2
  bBar = (bP/255)*math.pi*2

  cooldown = cooldown - dt

  if love.keyboard.isDown("space") and cooldown < 0 then
		local startX = player.x + 20 / 2
		local startY = player.y + 20 / 2
		local mouseX = love.mouse.getX()
		local mouseY = love.mouse.getY()

		local angle = math.atan2((mouseY - startY), (mouseX - startX))

		local bulletDx = bulletSpeed * math.cos(angle)
		local bulletDy = bulletSpeed * math.sin(angle)

		table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
    cooldown = cooldownMax
	end

  -- MOVEMENT --

  --restricting movement inside window

  if player.x > 1280 then
    player.xVel = player.xVel*-1
  end

  if player.x < 0 then
    player.xVel = player.xVel*-1
  end

  if player.y > 720 then
    player.yVel = player.yVel*-1
  end

  if player.y < 0 then
    player.yVel = player.yVel*-1
  end

  if player.xVel > 0 then
    player.xVel = player.xVel - .5
  end

  if player.xVel < 0 then
    player.xVel = player.xVel + .5
  end

  if player.yVel > 0 then
    player.yVel = player.yVel - .5
  end

  if player.yVel < 0 then
    player.yVel = player.yVel + .5
  end

  -- correlating velocity with player location

  player.x = player.x + player.xVel
  player.y = player.y + player.yVel

  -- keyboard movement changes velocity

  if love.keyboard.isDown("d") then
    if player.xVel > maxVel then

    else
      player.xVel = player.xVel + 1
    end
  end
  if love.keyboard.isDown("a") then
    if player.xVel < minVel then

    else
      player.xVel = player.xVel - 1
    end
  end
  if love.keyboard.isDown("s") then
    if player.yVel > maxVel then

    else
      player.yVel = player.yVel + 1
    end
  end
  if love.keyboard.isDown("w") then
    if player.yVel < minVel then

    else
      player.yVel = player.yVel - 1
    end
  end
  if love.keyboard.isDown("r") then
    if rP < 255 then
      rP = rP + 1
    end
  end
  if love.keyboard.isDown("g") then
    if gP < 255 then
      gP = gP + 1
      bulletSpeed = bulletSpeed + 5
    end
  end
  if love.keyboard.isDown("b") then
    if bP < 255 then
      bP = bP + 1
      cooldownMax = cooldownMax - 0.0025
    end
  end
  for i,bullet in ipairs(bullets) do
		bullet.x = bullet.x + (bullet.dx * dt)
		bullet.y = bullet.y + (bullet.dy * dt)
    if bullet.x > windowWidth or bullet.x < 0 or bullet.y > windowHeight or bullet.y < 0 then
      table.remove(bullets,i)
    end
	end
  if isAlive == false then
    status = 0
  else
    status = 1
  end
end

function player.draw()
  love.graphics.setLineWidth(1)
  for i,bullet in ipairs(bullets) do
    love.graphics.setColor(255,255,255)
    love.graphics.circle("line",bullet.x,bullet.y,10,24)
    love.graphics.setColor(rP,gP,bP)
    love.graphics.circle("fill",bullet.x,bullet.y,10,24)
  end
  love.graphics.setColor(rP,gP,bP)
  love.graphics.circle("fill",player.x,player.y,20,24)
  love.graphics.setColor(0,0,255)
  love.graphics.arc("line",player.x,player.y,35,0,bBar)
  love.graphics.setColor(0,255,0)
  love.graphics.arc("line",player.x,player.y,30,0,gBar)
  love.graphics.setColor(255,0,0)
  love.graphics.arc("line",player.x,player.y,25,0,rBar)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("line",player.x,player.y,20,24)
end
