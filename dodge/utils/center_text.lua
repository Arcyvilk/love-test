local vars = require 'vars'

local center_text = function(text, size)
  love.graphics.setNewFont(size)

  local font          = love.graphics.getFont()

  local text_width    = font:getWidth(text)
  local text_height   = font:getHeight()

  local screen_width  = vars.world_width
  local screen_height = vars.world_height

  love.graphics.print(
    text,
    screen_width / 2 - text_width / 2,
    screen_height / 2 - text_height / 2
  )

  love.graphics.setNewFont(12) -- reset font to default
end

return center_text
