files = {
  imagesDirectory = "img/",
  sfxDirectory = 'sfx/'
}
files.playerSpriteDirectory = files.imagesDirectory .. 'playerSprite/'
files.kamikazeSpriteDirectory = files.imagesDirectory .. 'kamiSprite/'
files.explosionSpriteDirectory = files.imagesDirectory .. 'explosionSprite/'
files.cloudSpriteDirectory = files.imagesDirectory .. 'cloudSprite/'
files.ammoBoxSpriteDirectory = files.imagesDirectory .. 'ammoBoxSprite/'

screen = {
  width = 1000,
  height = 600,
  inGameBG = love.graphics.newImage(files.imagesDirectory .. 'sky.png'),
  gameOverBG = love.graphics.newImage(files.imagesDirectory .. 'game_over_bg.png'),
  pauseBG = love.graphics.newImage(files.imagesDirectory .. 'pause_bg.png')
}

timer = 0

function changes_bg_music(current, next)
  current:stop()
  next:play()
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function is_colliding(x1,y1,l1,a1,x2,y2,l2,a2)
  return x2 < x1 + l1 and
         x1 < x2 + l2 and
         y1 < y2 + a2 and
         y2 < y1 + a1
end

function audio_repeat(source)
  source:stop()
  source:play()
end

function restart_game()
  math.randomseed(os.time())
  changes_bg_music(bg_game_over_music,bg_music)

  reset_player()
  airplane_sfx:play()

  ammoBoxes = {}
  enemies = {}
  spawnedClouds = {}

  GAME_OVER = false
end
