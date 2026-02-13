local vars = {
  gravity = 9.81,
  gravity_multiplier = 0,

  world_width = 800,
  world_height = 600,

  player_radius_min = 10,
  player_radius_max = 25,
  player_base_speed = 500,
  player_segments = 10,
  player_recovery_time = 0.75, -- seconds

  spawner_offset_x = 20,
  spawner_offset_y = 20,

  arrow_height = 50,
  arrow_width = 1,
  arrow_base_speed = 200,
  arrow_spawn_delay = 0.5,
  arrow_preparation_time = 60,
  arrow_ttl = 180,

  save_file_name = "save_data.txt",

  button_width = 200,
  button_height = 40
}

return vars
