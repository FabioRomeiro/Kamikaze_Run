playerBlueprint = {
  sprite = love.graphics.newImage(files.playerSpriteDirectory .. '1.png'),
  initPosition = {30,(screen.height/2)-(167/2)}, -- {x,y}
  frameScale = {160,58}, -- {w,h}
  numberFrames = 25,
  currentFrame = 1,
  delayBtwnFrames = 0.15,
  passedTimeSinceLastFrame = 0,
  velocity = 10,
  shots = {},
  ammo = 10,
  points = 0
}

character = deepcopy(playerBlueprint)
xyP = character.initPosition

function shoot()
  audio_repeat(shot_sfx)
  character.ammo = character.ammo -1

  local shot = {
    x = xyP[1]+character.frameScale[1],
    y = xyP[2]+(character.frameScale[2]/2)-4,
    width = 100,
    height = 34
  }

  table.insert(character.shots,shot)
end

function move_shot()
  for i=#character.shots,1,-1 do
    if character.shots[i].x < screen.width then
      character.shots[i].x = character.shots[i].x + 10
    else
      table.remove(character.shots,i)
    end
  end
end

function move_player()
  if love.keyboard.isDown('w') then xyP[2] = xyP[2] - character.velocity end
  if love.keyboard.isDown('s') then xyP[2] = xyP[2] + character.velocity end
  if love.keyboard.isDown('d') then xyP[1] = xyP[1] + character.velocity end
  if love.keyboard.isDown('a') then xyP[1] = xyP[1] - character.velocity end
end

function check_collision()
  check_airplane_collision()
  check_shot_collision()
  check_ammobox_collision()
end

function check_airplane_collision()
  for k,kami in pairs(enemies) do
    if is_colliding(kami.x,kami.y,160,26,xyP[1],xyP[2],character.frameScale[1],character.frameScale[2]) then
      changes_bg_music(bg_music,bg_game_over_music)
      destroy_airplane()
      destroy_kami_airplane(kami)
      GAME_OVER = true
    end
  end
end

function check_ammobox_collision()
  for i=#ammoBoxes,1,-1 do
    if(is_colliding(character.initPosition[1], character.initPosition[2], character.frameScale[1], character.frameScale[2],
                    ammoBoxes[i].x, ammoBoxes[i].y, box.frameScale[1], box.frameScale[2])) then
            table.remove(ammoBoxes,i)
            increment_ammo(5)
            audio_repeat(ammo_sfx)
            break
    end
  end
end

function check_shot_collision()
  for i=#character.shots,1,-1 do
    for j=#enemies,1,-1 do
      if(is_colliding(character.shots[i].x, character.shots[i].y, character.shots[i].width, character.shots[i].height,
                      enemies[j].x, enemies[j].y, kamikaze.frameScale[1], kamikaze.frameScale[2])) then
              audio_repeat(enemy_explosion_sfx)
              table.remove(character.shots,i)
              table.remove(enemies,j)
              increment_points(100)
              break
      end
    end
  end
end

function destroy_airplane()
  single_explosion_sfx:play()
  airplane_sfx:stop()
  character.sprite = love.graphics.newImage(files.explosionSpriteDirectory .. '1.png')
end

function increment_points(add)
  character.points = character.points + add
end

function increment_ammo(add)
  character.ammo = character.ammo + add
end

function reset_player()
  character = deepcopy(playerBlueprint)
  xyP = character.initPosition
end
