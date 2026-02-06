local world               = require 'world'
local vars                = require 'vars'
local normalize           = require 'utils.normalize'

local segment_radius_step = (vars.player_radius_max - vars.player_radius_min) / vars.player_segments

local create_head         = function()
  local head = {}
  local target = {}

  head.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
  head.shape = love.physics.newCircleShape(segment_radius_step * vars.player_segments)
  head.fixture = love.physics.newFixture(head.body, head.shape)

  head.update = function(self)
    local px, py = self.body:getPosition()

    target.x, target.y = love.mouse.getPosition()
    local vx, vy = normalize(target.x - px, target.y - py)
    local distance_factor = {
      x = math.abs(target.x - px) / 100,
      y = math.abs(target.y - py) / 100
    }
    self.body:setLinearVelocity(
      vx * distance_factor.x * vars.player_base_speed,
      vy * distance_factor.y * vars.player_base_speed)
  end

  head.draw = function(self)
    local x, y = self.body:getPosition()
    love.graphics.circle('fill', x, y, self.shape:getRadius())
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.line(x, y, target.x, target.y)
    love.graphics.setColor(1, 1, 1, 1)
  end

  return head
end

--- @param index number
local create_segment      = function(index, prev_segment)
  local segment = {}
  local target = {}

  segment.body = love.physics.newBody(world, vars.world_width / 2, vars.world_height / 2, 'kinematic')
  segment.shape = love.physics.newCircleShape(segment_radius_step * (vars.player_segments - index))
  segment.fixture = love.physics.newFixture(segment.body, segment.shape)

  segment.update = function(self)
    local px, py = self.body:getPosition()

    target.x, target.y = prev_segment.body:getPosition()
    local vx, vy = normalize(px - target.x, py - target.y)
    local spacing = prev_segment.shape:getRadius() * 2
    local x = target.x + spacing * vx
    local y = target.y + spacing * vy

    self.body:setPosition(x, y)
  end

  segment.draw = function(self)
    local x, y = self.body:getWorldCenter()
    love.graphics.circle('line', x, y, self.shape:getRadius())
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.line(x, y, target.x, target.y)
    love.graphics.setColor(1, 1, 1, 1)
  end

  return segment
end


local create_segments = function(head)
  local segments = {}
  local index = 1

  while index < vars.player_segments do
    local prev_segment = index == 1 and head or segments[index - 1]
    table.insert(segments, create_segment(index, prev_segment))
    index = index + 1
  end

  return segments
end

local create_player   = function()
  local player    = {
    head = {},
    segments = {}
  }

  player.head     = create_head()
  player.segments = create_segments(player.head)

  player.update   = function(delta)
    player.head:update()
    for _, segment in ipairs(player.segments) do
      segment:update(delta)
    end
  end

  player.draw     = function()
    player.head:draw()
    for _, segment in ipairs(player.segments) do
      segment:draw()
    end
  end

  return player
end

local player          = create_player()

return player
