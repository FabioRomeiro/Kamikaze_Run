listAirplaneFrames = {}

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

function destroy_airplane()
  -- character.quad = love.graphics.newQuad(character.frameScale[1],character.frameScale[2],character.frameScale[1],character.frameScale[2],character.frameScale[1],character.frameScale[2])
  single_explosion_sfx:play()
  airplane_sfx:stop()
  character.sprite = love.graphics.newImage(files.explosionSpriteDirectory .. '1.png')
end

function destroy_kami_airplane(kami)
  single_kami_explosion_sfx:play()
  kami.sprite = love.graphics.newImage(files.explosionSpriteDirectory .. '2.png')
end
