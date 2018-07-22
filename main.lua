require "system"
require "player"
require "kamikaze"
require "sprites"
require "sfx"

function love.load()
  math.randomseed(os.time())

  love.window.setTitle('Kamikaze Run')
  love.window.setMode(screen.width, screen.height, {resizable = false})

  bullet_sprite = love.graphics.newImage(files.imagesDirectory..'bullet.png')

  bg_music:play()

  airplane_sfx:play()

  -- listPlayerSprites()
end


function love.update(dt)
  timer = timer + dt
  if not GAME_OVER and not PAUSE then
    if love.keyboard.isDown('w','a','s','d') then
      movePlayer()
    end

    clearAmmoBoxes()
    clearEnemies()
    clearClouds()

    if #ammoBoxes < box.max and timer >= math.random(5,10) then
      spawnAmmoBox()
      timer = 0
    end
    if #enemies < kamikaze.max then
      spawnEnemy()
    end
    if #spawnedClouds < cloud.max then
      spawnCloud()
    end
    moveAmmoBox()
    moveEnemy()
    moveCloud()
    moveShot()

    check_collision()
  end
end


function love.draw()
  love.graphics.draw(screen.inGameBG,0,0)
  character.draw = love.graphics.draw(character.sprite,xyP[1],xyP[2])

  for k,ammobox in pairs(ammoBoxes) do
    love.graphics.draw(ammobox.sprite,ammobox.x,ammobox.y)
  end

  for k,kami in pairs(enemies) do
    love.graphics.draw(kami.sprite,kami.x,kami.y)
  end

  for k,cloud in pairs(spawnedClouds) do
    love.graphics.draw(cloud.sprite,cloud.x,cloud.y)
  end

  for k,shot in pairs(character.shots) do
    love.graphics.draw(bullet_sprite,shot.x,shot.y)
  end

  if GAME_OVER then
    love.graphics.draw(screen.gameOverBG,0,0)
  end

  if PAUSE then
    love.graphics.draw(screen.pauseBG,0,0)
  end

  showPoints(character.points)
  showAmmo(character.ammo)
end

function love.keypressed(input)
  if input == 'escape' then
    love.event.quit()
  end
  if not GAME_OVER then
    if input == 'p' then
      if PAUSE then
        PAUSE = false
        airplane_sfx:play()
      else
        PAUSE = true
        airplane_sfx:stop()
      end
    end
    if input == 'space' then
      if character.ammo>0 then
        shoot()
      else
        out_of_ammo_sfx:stop()
        out_of_ammo_sfx:play()
      end
    end
  end
  if GAME_OVER and input == 'r' then
    restart_game()
  end
end
