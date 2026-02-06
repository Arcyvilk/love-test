local vars = require 'vars'

---comment
---@param text string
---@param size number
---@param color table
local center_text = function(text, size, color)
  love.graphics.setNewFont(size)
  love.graphics.setColor(color[1], color[2], color[3])

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

  love.graphics.setNewFont(12)    -- reset font to default
  love.graphics.setColor(1, 1, 1) -- reset color to default
end

return center_text
