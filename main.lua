require "system"
require "player"
require "kamikaze"
require "sprites"

-- Load some default values for our rectangle.
function love.load()
  math.randomseed(os.time())

  love.window.setTitle('Kamikaze Run')
  love.window.setMode(screen.width, screen.height, {resizable = false})

  listPlayerSprites()
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  animatePlayerSprite(dt)
  if love.keyboard.isDown('w','a','s','d') then movePlayer() end

  clearEnemies()
  if #enemies < kamikaze.max then
    spawnEnemy()
  end
  moveEnemy()
end

-- Draw a coloured rectangle.
function love.draw()
  love.graphics.draw(screen.inGameBG,0,0)

  love.graphics.draw(character.sprite,listAirplaneFrames[character.currentFrame],xyP[1],xyP[2])

  for k,kami in pairs(enemies) do
    love.graphics.draw(kamikaze.sprite,kami.x,kami.y)
  end

end
