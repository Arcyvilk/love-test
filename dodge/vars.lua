local vars = {
  gravity = 9.81,
  gravity_multiplier = 0,

  world_width = 800,
  world_height = 600,

  player_radius_min = 10,
  player_radius_max = 25,
  player_base_speed = 500,
  player_segments = 25,
  player_recovery_time = 0.5, -- seconds

  spawner_offset_x = 20,
  spawner_offset_y = 20,

  arrow_height = 50,
  arrow_width = 1,
  arrow_base_speed = 750,
  arrow_spawn_delay = 0.25
}

return vars
