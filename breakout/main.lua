local world = require 'world'
local input = require 'input'
local boundaries, bricks, entities = unpack(require 'entities')

local draw_boundaries = function()
  for _, entity in ipairs(boundaries) do
    if entity.draw then entity:draw() end
  end
end

local draw_bricks = function()
  for _, entity in ipairs(bricks) do
    if entity.draw then entity:draw() end
  end
end

local draw_entities = function()
  for _, entity in ipairs(entities) do
    if entity.draw then entity:draw() end
  end
end

love.draw = function()
  -- draw_boundaries() -- disabled to keep the boundaries invisible
  draw_bricks()
  draw_entities()
end

love.focus = function(focused)
  input.toggle_focus(focused)
end

love.keypressed = function(pressed_key)
  input.press(pressed_key)
end

love.keyreleased = function(released_key)
  input.release(released_key)
end

love.update = function(dt)
  if input.paused then return end

  for _, entity in ipairs(entities) do
    if entity.update then
      entity:update()
    end
  end

  world:update(dt)
end
