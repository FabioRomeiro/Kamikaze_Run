require "system"
require "player"
require "kamikaze"
require "sprites"


function love.load()
  math.randomseed(os.time())

  love.window.setTitle('Kamikaze Run')
  love.window.setMode(screen.width, screen.height, {resizable = false})

  bullet_sprite = love.graphics.newImage(files.imagesDirectory..'bullet.png')

  bg_music = love.audio.newSource(files.sfxDirectory.."bg_game_music.wav",'stream')
  bg_music:setLooping(true)
  bg_music:play()

  airplane_sfx = love.audio.newSource(files.sfxDirectory.."airplane.mp3",'stream')
  airplane_sfx:setLooping(true)
  airplane_sfx:setVolume(0.1)
  airplane_sfx:play()

  single_explosion_sfx = love.audio.newSource(files.sfxDirectory.."single_explosion.wav",'static')
  enemy_explosion_sfx = love.audio.newSource(files.sfxDirectory.."enemy_explosion.wav",'static')
  shot_sfx = love.audio.newSource(files.sfxDirectory.."shot.wav",'static')
  single_kami_explosion_sfx = love.audio.newSource(files.sfxDirectory.."single_kami_explosion.wav",'static')
  bg_game_over_music = love.audio.newSource(files.sfxDirectory.."bg_game_over_music.wav",'stream')
  -- listPlayerSprites()
end


function love.update(dt)
  -- animatePlayerSprite(dt)
  if not GAME_OVER then
    if love.keyboard.isDown('w','a','s','d') then movePlayer() end

    clearEnemies()
    clearClouds()
    if #enemies < kamikaze.max then
      spawnEnemy()
    end
    if #spawnedClouds < cloud.max then
      spawnCloud()
    end
    moveEnemy()
    moveCloud()
    moveShot()

    check_collision()
  end
end


function love.draw()
  love.graphics.draw(screen.inGameBG,0,0)
  character.draw = love.graphics.draw(character.sprite,xyP[1],xyP[2])

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
end

function love.keypressed(input)
  if input == 'escape' then
    love.event.quit()
  end
  if not GAME_OVER then
    if input == 'space' then
      shoot()
    end
  end
end
