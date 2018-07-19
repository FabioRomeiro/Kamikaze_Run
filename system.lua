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
