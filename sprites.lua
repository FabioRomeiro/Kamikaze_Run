listAirplaneFrames = {}

cloud = {
  initPosition = {screen.width + 167, math.random(screen.height)}, -- {x,y}
  frameScale = {600,355}, -- {w,h}
  max = 3
}

spawnedClouds = {}
ammoBoxes = {}

scorefont = love.graphics.newFont("font/Kamikaze3DGradient.ttf", 32)
score = {
  points = love.graphics.newText(scorefont, "0"),
}

function showPoints(points)
  text = 'People saved: ' .. tostring(points)
  score.points:set(text)
  love.graphics.draw(score.points, 100, 25, 0)
end

function showAmmo(ammo)
  text = 'Ammo: ' .. tostring(ammo)
  score.points:set (text)
  love.graphics.draw(score.points, screen.width - 300, 25, 0)
end

function spawnCloud()
  spawnedCloud = {
    x = cloud.initPosition[1],
    y = math.random(-cloud.frameScale[2],screen.height),
    velocity = math.random(3,15),
    sprite = love.graphics.newImage(files.cloudSpriteDirectory .. tostring(math.random(1,3)) .. '.png'),
  }
  scaleNumber = math.random()
  spawnedCloud.scale = love.graphics.scale(scaleNumber, scaleNumber)
  table.insert(spawnedClouds,spawnedCloud)
end


function moveCloud()
  for k, cloud in pairs(spawnedClouds) do
    cloud.x = cloud.x - cloud.velocity
  end
end

function clearClouds()
  for i = #spawnedClouds,1,-1 do
    if spawnedClouds[i].x < -cloud.frameScale[1] then
      table.remove(spawnedClouds, i)
    end
  end
end

box = {
  initPosition = {math.random(screen.width), -144}, -- {x,y}
  frameScale = {100,144}, -- {w,h}
  max = 1
}

function spawnAmmoBox()
  ammoBox = {
    x = math.random(box.initPosition[1]),
    y = box.initPosition[2],
    velocity = 3,
    displacement = math.random(-1,1),
    sprite = love.graphics.newImage(files.ammoBoxSpriteDirectory .. '1.png')
  }
  table.insert(ammoBoxes,ammoBox)
end

function moveAmmoBox()
  for k, ammobox in pairs(ammoBoxes) do
    ammobox.y = ammobox.y + ammobox.velocity
    ammobox.x = ammobox.x + ammobox.displacement
  end
end

function clearAmmoBoxes()
  for i = #ammoBoxes,1,-1 do
    if ammoBoxes[i].y > screen.height then
      table.remove(ammoBoxes, i)
    end
  end
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
