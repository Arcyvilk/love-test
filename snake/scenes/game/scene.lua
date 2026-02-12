local input                          = require 'scenes.game.input'
local create_scene                   = require 'scenes.create_scene'
local player                         = require 'entities.player'
local draw_spawners, update_spawners = unpack(require 'entities.entities')

return function(scene_manager)
  local scene = create_scene({
    name = 'scene_game',

    keybindings = input(scene_manager),

    init = function()
      player:reset()
    end,

    mousepressed = function(self, x, y, mouse_button)
      return
    end,

    draw = function(self)
      if player.is_dead then
        scene_manager:move_to('scene_end')
        return
      end

      player:draw()
      draw_spawners()
    end,

    update = function(self, delta)
      if player.is_dead then return end

      player:update(delta)
      update_spawners(delta)
    end
  })

  return scene
end
