files = {
  imagesDirectory = "img/",
  playerSpriteDirectory = 'img/playerSprite/'
}

screen = {
  width = 1000,
  height = 600,
  inGameBG = love.graphics.newImage(files.imagesDirectory .. 'sky.png')
}

character = {
  sprite = love.graphics.newImage(files.playerSpriteDirectory .. 'sprite.png'),
  initPosition = {30,(screen.height/2)-(167/2)}, -- {x,y}
  frameScale = {160,167}, -- {w,h}
  numberFrames = 25,
  currentFrame = 1,
  delayBtwnFrames = 0.15,
  passedTimeSinceLastFrame = 0
}

listAirplaneFrames = {}

xy = character.initPosition

function movePlayer()
  if love.keyboard.isDown('w') then xy[2] = xy[2] - 1 end
  if love.keyboard.isDown('s') then xy[2] = xy[2] + 1 end
  if love.keyboard.isDown('d') then xy[1] = xy[1] + 1 end
  if love.keyboard.isDown('a') then xy[1] = xy[1] - 1 end
end

function listPlayerSprites()
  for frame = 1,character.numberFrames do
    listAirplaneFrames[frame] = love.graphics.newQuad((frame-1)*character.frameScale[1],0,character.frameScale[1],character.frameScale[2],4000,167)
  end
end

countToLoop = 0


function animatePlayerSprite(dt)
  c = character
  loopDivisor = 12

  c.passedTimeSinceLastFrame = c.passedTimeSinceLastFrame + dt

  if c.passedTimeSinceLastFrame > c.delayBtwnFrames then

    c.passedTimeSinceLastFrame = c.passedTimeSinceLastFrame - c.delayBtwnFrames
    if c.currentFrame == 2 then
      if countToLoop%loopDivisor~=0 then
        c.currentFrame = 24
      elseif c.currentFrame == 2 and countToLoop%loopDivisor==0 then
        c.currentFrame = c.currentFrame + 1
      end
    else
      c.currentFrame = c.currentFrame + 1
    end

    if c.currentFrame > c.numberFrames then
      c.currentFrame = 1
    end

    if c.currentFrame == c.numberFrames then
      countToLoop = countToLoop + 1
    end
  end
end



-- Load some default values for our rectangle.
function love.load()
  love.window.setTitle('Kamikaze Run')
  love.window.setMode(screen.width, screen.height, {resizable = false})

  listPlayerSprites()
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  animatePlayerSprite(dt)

  if love.keyboard.isDown('w','a','s','d') then movePlayer() end
end

-- Draw a coloured rectangle.
function love.draw()
  love.graphics.draw(screen.inGameBG,0,0)
  love.graphics.draw(character.sprite,listAirplaneFrames[character.currentFrame],xy[1],xy[2])

end
