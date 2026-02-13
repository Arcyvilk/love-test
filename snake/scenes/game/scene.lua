local input                                          = require 'scenes.game.input'
local create_scene                                   = require 'scenes.create_scene'
local player                                         = require 'entities.player'
local status_bar                                     = require 'ui.status_bar'
local reset_spawners, draw_spawners, update_spawners = unpack(require 'entities.entities')

return function(scene_manager)
  local scene = create_scene({
    name = 'scene_game',

    keybindings = input(scene_manager),

    mousepressed = function(self, x, y, mouse_button)
      return
    end,

    init = function()
      reset_spawners()
      player:reset()
    end,

    draw = function(self)
      if player.is_dead then
        scene_manager:move_to('scene_end')
        return
      end

      player:draw()
      status_bar.draw()
      draw_spawners()
    end,

    update = function(self)
      if player.is_dead then return end

      player:update()
      update_spawners()
    end
  })

  return scene
end
