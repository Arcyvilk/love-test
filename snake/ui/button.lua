local center_text   = require 'utils.center_text'
local vars          = require 'vars'

---@param label string
---@param offset_x number
---@param offset_y number
---@param width number
---@param height number
---@param on_click function
local create_button = function(label, offset_x, offset_y, width, height, on_click)
  local button = {
    label = label,
    x = vars.world_width / 2 - width / 2 + offset_x,
    y = vars.world_height / 2 - height / 2 + offset_y,
    width = width,
    height = height,
    is_hovered = false,
    on_click = on_click
  }

  button.check_hover = function(self)
    local x_mouse, y_mouse = love.mouse.getPosition()

    if x_mouse > self.x and x_mouse < self.x + self.width then
      if y_mouse > self.y and y_mouse < self.y + self.height then
        self.is_hovered = true
        return
      end
    end

    self.is_hovered = false
  end

  button.click = function(self, x, y, mouse_button)
    if self.is_hovered then
      self:on_click()
    end
  end

  button.update = function(self)
    button:check_hover()
  end

  button.draw = function(self)
    if self.is_hovered then
      love.graphics.setColor({ 0.5, 0.7, 0.98, 1 })
    else
      love.graphics.setColor({ 0.4, 0.6, 0.88, 1 })
    end

    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor({ 1, 1, 1, 1 })

    center_text({
      text = self.label,
      size = 'm',
      color = { 0, 0, 0, 1 },
      offset_x = 0,
      offset_y = 0,
      parent = { x = self.x, y = self.y, width = self.width, height = self.height }
    })
  end

  return button
end

return create_button
