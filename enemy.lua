enemies = {}
enemy = {}

function enemy.load()
  createEnemyTimerMax = .5
  createEnemyTimer = 0
  enemyBulletCooldown = 0
  enemySpeed = 200
end

function enemy.update(dt)

  createEnemyTimer = createEnemyTimer - dt
  enemyBulletCooldown = enemyBulletCooldown - dt
  if createEnemyTimer < 0 then
    local color = math.random(0,2)
    local startX = love.math.random(0,1280)
		local startY = 0

		local angle = math.atan2((player.y - startY), (player.x - startX))

		local enemyDx = enemySpeed * math.cos(angle)
		local enemyDy = enemySpeed * math.sin(angle)

		table.insert(enemies, {x = startX, y = startY, dx = enemyDx, dy = enemyDy, redColor = 0, blueColor = 0, greenColor = 0, color = math.random(0,2)})
    createEnemyTimer = createEnemyTimerMax
  end

  for i,enemy in ipairs(enemies) do
		enemy.x = enemy.x + (enemy.dx * dt)
		enemy.y = enemy.y + (enemy.dy * dt)
    if enemy.x > windowWidth then
      enemy.dx = enemy.dx * -1
    end
    if enemy.x < 0 then
      enemy.dx = enemy.dx * -1
    end
    if enemy.y < 0 then
      enemy.dy = enemy.dy * -1
    end
    if enemy.y > windowHeight then
      enemy.dy = enemy.dy * -1
    end
    if enemy.color == 0 then
      enemy.redColor = 0
      enemy.greenColor = 0
      enemy.blueColor = 255
    elseif enemy.color == 1 then
      enemy.redColor = 0
      enemy.greenColor = 255
      enemy.blueColor = 0
    elseif enemy.color == 2 then
      enemy.redColor = 255
      enemy.greenColor = 0
      enemy.blueColor = 0
    end
    for j, bullet in ipairs(bullets) do
      if CheckCollision(enemy.x, enemy.y, 30, 30, bullet.x, bullet.y, 20, 20) then
        table.remove(bullets, j)
        table.remove(enemies, i)
        if enemy.color == 0 then
          if bP < 255 then
            bP = bP + 1
            cooldownMax = cooldownMax - 0.0025
          end
        elseif enemy.color == 1 then
          if gP < 255 then
            gP = gP + 1
            bulletSpeed = bulletSpeed + 5
          end
        elseif enemy.color == 2 then
          if  rP < 255 then
            rP = rP + 1
            bulletDamage = bulletDamage + 1
          end
        end
    end
  end
  if CheckCollision(enemy.x, enemy.y, 20, 20, player.x, player.y, 10, 10) then
    table.remove(enemies, i)
    isAlive = false
  end
  end
end

function enemy.draw()
  for i, enemy in ipairs(enemies) do
    love.graphics.setColor(enemy.redColor,enemy.greenColor,enemy.blueColor)
    love.graphics.circle("line",enemy.x,enemy.y,20,32)
  end
end
