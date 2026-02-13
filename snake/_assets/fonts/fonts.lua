local fonts = {}

fonts.load = function(self)
  fonts.s = love.graphics.newFont("_assets/fonts/Doto/Doto.ttf", 16)
  fonts.m = love.graphics.newFont("_assets/fonts/Doto/Doto.ttf", 24)
  fonts.l = love.graphics.newFont("_assets/fonts/Doto/Doto.ttf", 32)
  fonts.xl = love.graphics.newFont("_assets/fonts/Doto/Doto.ttf", 72)

  love.graphics.setFont(fonts.s)
end

return fonts
