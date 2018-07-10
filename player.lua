character = {
  sprite = love.graphics.newImage(files.playerSpriteDirectory .. 'sprite.png'),
  initPosition = {30,(screen.height/2)-(167/2)}, -- {x,y}
  frameScale = {160,167}, -- {w,h}
  numberFrames = 25,
  currentFrame = 1,
  delayBtwnFrames = 0.15,
  passedTimeSinceLastFrame = 0,
  velocity = 10
}

xyP = character.initPosition

function movePlayer()
  if love.keyboard.isDown('w') then xyP[2] = xyP[2] - character.velocity end
  if love.keyboard.isDown('s') then xyP[2] = xyP[2] + character.velocity end
  if love.keyboard.isDown('d') then xyP[1] = xyP[1] + character.velocity end
  if love.keyboard.isDown('a') then xyP[1] = xyP[1] - character.velocity end
end
