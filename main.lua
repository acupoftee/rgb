function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

require 'player'
require 'enemy'
require 'particles'
require 'camera'

function love.load()
  windowHeight = love.graphics.getHeight()
  windowWidth = love.graphics.getWidth()
  particles.load()
  player.load()
  enemy.load()
end

function love.update(dt)
  particles.update(dt)
  player.update(dt)
  enemy.update(dt)
  if love.keyboard.isDown("escape") then
    love.window.close()
  end
end

function love.draw()
  camera:set()
  love.graphics.setBackgroundColor(0,0,0)
  particles.draw()
  player.draw()
  enemy.draw()
  camera:unset()
end
