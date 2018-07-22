bg_music = love.audio.newSource(files.sfxDirectory.."bg_game_music.wav",'stream')
bg_music:setLooping(true)

airplane_sfx = love.audio.newSource(files.sfxDirectory.."airplane.mp3",'stream')
airplane_sfx:setLooping(true)
airplane_sfx:setVolume(0.1)

shot_sfx = love.audio.newSource(files.sfxDirectory.."shot.wav",'static')

ammo_sfx = love.audio.newSource(files.sfxDirectory.."ammo.wav",'static')
out_of_ammo_sfx = love.audio.newSource(files.sfxDirectory.."out_of_ammo.wav",'static')

single_explosion_sfx = love.audio.newSource(files.sfxDirectory.."single_explosion.wav",'static')
enemy_explosion_sfx = love.audio.newSource(files.sfxDirectory.."enemy_explosion.wav",'static')
single_kami_explosion_sfx = love.audio.newSource(files.sfxDirectory.."single_kami_explosion.wav",'static')

bg_game_over_music = love.audio.newSource(files.sfxDirectory.."bg_game_over_music.wav",'stream')
