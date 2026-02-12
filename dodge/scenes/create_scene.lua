---@class SceneArgs
---@field name string
---@field draw fun(self: table, dt:number)
---@field update fun(self: table, dt:number)
---@field keypressed fun(key:string)
---@field keyreleased fun(key:string)

---@param args SceneArgs
local create_scene = function(args)
  local name, draw, update, keypressed, keyreleased = unpack(args)
  local scene = {
    name = name,
    draw = draw,
    update = update,
    keypressed = keypressed,
    keyreleased = keyreleased
  }

  return scene
end

return create_scene
