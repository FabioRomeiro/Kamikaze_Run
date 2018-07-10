files = {
  imagesDirectory = "img/",
  playerSpriteDirectory = 'img/playerSprite/',
  kamikazeSpriteDirectory = 'img/kamiSprite/'
}

screen = {
  width = 1000,
  height = 600,
  inGameBG = love.graphics.newImage(files.imagesDirectory .. 'sky.png')
}
