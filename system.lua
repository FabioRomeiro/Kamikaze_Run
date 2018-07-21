files = {
  imagesDirectory = "img/",
  sfxDirectory = 'sfx/'
}
files.playerSpriteDirectory = files.imagesDirectory .. 'playerSprite/'
files.kamikazeSpriteDirectory = files.imagesDirectory .. 'kamiSprite/'
files.explosionSpriteDirectory = files.imagesDirectory .. 'explosionSprite/'
files.cloudSpriteDirectory = files.imagesDirectory .. 'cloudSprite/'

screen = {
  width = 1000,
  height = 600,
  inGameBG = love.graphics.newImage(files.imagesDirectory .. 'sky.png'),
  gameOverBG = love.graphics.newImage(files.imagesDirectory .. 'game_over_bg.png')
}

function changes_bg_music(current, next)
  current:stop()
  next:play()
end

function restart_game()
  math.randomseed(os.time())
  changes_bg_music(bg_game_over_music,bg_music)

  reset_player()
  enemies = {}
  spawnedClouds = {}

  GAME_OVER = false
end