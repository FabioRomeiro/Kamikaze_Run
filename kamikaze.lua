kamikaze = {
  sprite = love.graphics.newImage(files.kamikazeSpriteDirectory .. 'kami.png'),
  initPosition = {screen.width + 167, math.random(screen.height)}, -- {x,y}
  frameScale = {160,167}, -- {w,h}
  max = 8
}

enemies = {}

function spawnEnemy()
  enemy = {
    x = kamikaze.initPosition[1],
    y = math.random(-kamikaze.frameScale[2],screen.height),
    velocity = math.random(3,15),
    displacement = math.random(-1,1)
  }
  table.insert(enemies,enemy)
end

function moveEnemy()
  for k, kami in pairs(enemies) do
    kami.x = kami.x - kami.velocity
    kami.y = kami.y + kami.displacement
  end
end

function clearEnemies()
  for i = #enemies,1,-1 do
    if enemies[i].x < -kamikaze.frameScale[1] then
      table.remove(enemies, i)
    end
  end
end
