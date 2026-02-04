local vars = require 'vars'

love.conf = function(t)
  t.console = true                    -- Enable the debug console for Windows.
  t.window.width = vars.world_width   -- Game's screen width (number of pixels)
  t.window.height = vars.world_height -- Game's screen height (number of pixels)
end
