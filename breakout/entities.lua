local vars = require 'vars'

local ball = require 'entities.ball'
local boundary = require 'entities.boundary'
local brick = require 'entities.brick'
local paddle = require 'entities.paddle'

-- Take the brick amount and divide them into rows and columns
-- based on the world size.
-- [TODO] center the last row?
local get_bricks = function()
  local columns = math.floor((vars.world_width - vars.brick_gap) / (vars.brick_width + vars.brick_gap))
  local rows = math.ceil(vars.brick_amount / columns)
  local last_column = vars.brick_amount % columns

  local bricks = {}

  for y = 1, rows, 1
  do
    local bricks_in_row = columns * y >= vars.brick_amount and last_column or columns
    for x = 1, bricks_in_row, 1
    do
      local x_pos = x * vars.brick_gap + x * vars.brick_width - vars.brick_width / 2
      local y_pos = y * vars.brick_gap + y * vars.brick_height - vars.brick_height / 2
      local entity = brick(x_pos, y_pos)
      table.insert(bricks, entity)
    end
  end


  return bricks
end

local boundaries = {
  boundary('top'),
  boundary('bottom'),
  boundary('left'),
  boundary('right')
}

local entities = {
  paddle(vars.world_width / 4 * 2, vars.world_height / 10 * 9),
  ball(vars.world_width / 4 * 2, vars.world_height / 4 * 2)
}

local bricks = get_bricks()

return { boundaries, bricks, entities }
