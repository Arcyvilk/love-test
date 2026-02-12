local input        = require 'scenes.game.input'
local create_scene = require 'scenes.create_scene'
local player       = require 'entities.player'

return function(scene_manager)
  local scene = create_scene({
    name = 'scene_game',

    keybindings = input(scene_manager),

    mousepressed = function(self, x, y, mouse_button)
      return
    end,

    draw = function(self, delta)
      if player.is_dead then
        scene_manager:move_to('scene_end')
      end

      player:draw(delta)
    end,

    update = function(self, delta)
      if player.is_dead then return end

      player:update(delta)
    end
  })

  return scene
end
