local world = require 'world'

local dev = {
  debug = false,
  draw_physics = function()
    love.graphics.setColor({ 0, 1, 0, 1 })

    for _, body in ipairs(world:getBodies()) do
      for _, fixture in ipairs(body:getFixtures()) do
        local shape = fixture:getShape()

        if shape:typeOf("CircleShape") then
          local x, y = body:getWorldPoints(shape:getPoint())
          love.graphics.circle("line", x, y, shape:getRadius())
        elseif shape:typeOf("PolygonShape") then
          love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
        elseif shape:typeOf("EdgeShape") or shape:typeOf("ChainShape") then
          love.graphics.line(body:getWorldPoints(shape:getPoints()))
        end
      end
    end

    love.graphics.setColor({ 1, 1, 1, 1 })
  end
}

return dev
