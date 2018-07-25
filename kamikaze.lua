kamikaze = {
  initPosition = {screen.width + 167, math.random(screen.height)}, -- {x,y}
  frameScale = {160,26}, -- {w,h}
  max = 3
}

enemies = {}

function spawn_enemy()
  enemy = {
    x = kamikaze.initPosition[1],
    y = math.random(-kamikaze.frameScale[2],screen.height),
    velocity = math.random(3,10),
    displacement = math.random(-1,1),
    sprite = love.graphics.newImage(files.kamikazeSpriteDirectory .. 'kami.png')
  }
  table.insert(enemies,enemy)
end

function move_enemy()
  for k, kami in pairs(enemies) do
    kami.x = kami.x - kami.velocity
    kami.y = kami.y + kami.displacement
  end
end

function clear_enemies()
  for i = #enemies,1,-1 do
    if enemies[i].x < -kamikaze.frameScale[1] then
      table.remove(enemies, i)
    end
  end
end

function destroy_kami_airplane(kami)
  single_kami_explosion_sfx:play()
  kami.sprite = love.graphics.newImage(files.explosionSpriteDirectory .. '2.png')
end
