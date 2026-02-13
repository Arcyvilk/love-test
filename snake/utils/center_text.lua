local fonts       = require '_assets.fonts.fonts'

---@class CenterTextArgs
---@field text string
---@field size 's'|'m'|'l'|'xl'
---@field color table
---@field offset_x number
---@field offset_y number
---@field parent { x: number, y: number, width: number, height: number }

---@param args CenterTextArgs
local center_text = function(args)
  love.graphics.setColor(args.color)
  love.graphics.setFont(fonts[args.size])
  local font = love.graphics.getFont()
  font:setFilter("nearest", "nearest")

  local text_width  = font:getWidth(args.text)
  local text_height = font:getHeight()

  love.graphics.print(
    args.text,
    args.parent.x + args.parent.width / 2 - text_width / 2 + args.offset_x,
    args.parent.y + args.parent.height / 2 - text_height / 2 + args.offset_y
  )

  love.graphics.setFont(fonts.s)  -- reset font to default
  love.graphics.setColor(1, 1, 1) -- reset color to default
end

return center_text
