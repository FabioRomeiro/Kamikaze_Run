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

function show_points(points)
  text = 'People saved: ' .. tostring(points)
  score.points:set(text)
  love.graphics.draw(score.points, 100, 25, 0)
end

function show_ammo(ammo)
  text = 'Ammo: ' .. tostring(ammo)
  score.points:set (text)
  love.graphics.draw(score.points, screen.width - 300, 25, 0)
end

function spawn_cloud()
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

function move_cloud()
  for k, cloud in pairs(spawnedClouds) do
    cloud.x = cloud.x - cloud.velocity
  end
end

function clear_clouds()
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

function spawn_ammo_box()
  ammoBox = {
    x = math.random(box.initPosition[1]),
    y = box.initPosition[2],
    velocity = 3,
    displacement = math.random(-1,1),
    sprite = love.graphics.newImage(files.ammoBoxSpriteDirectory .. '1.png')
  }
  table.insert(ammoBoxes,ammoBox)
end

function move_ammo_box()
  for k, ammobox in pairs(ammoBoxes) do
    ammobox.y = ammobox.y + ammobox.velocity
    ammobox.x = ammobox.x + ammobox.displacement
  end
end

function clear_ammo_boxes()
  for i = #ammoBoxes,1,-1 do
    if ammoBoxes[i].y > screen.height then
      table.remove(ammoBoxes, i)
    end
  end
end
