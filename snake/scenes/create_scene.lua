---@class SceneArgs
---@field name string
---@field keybindings table
---@field draw fun(self: table, delta: number)
---@field update fun(self: table, delta: number)
---@field mousepressed fun(self: table, x: number, y: number, button: number)

---@param args SceneArgs
local create_scene = function(args)
  local scene = {}

  scene.name = args.name
  scene.draw = args.draw
  scene.update = args.update
  scene.mousepressed = args.mousepressed

  ---@type fun(self: table, key:string)
  scene.keypressed = function(self, key)
    if args.keybindings[key] then
      args.keybindings[key]:press()
    end
  end

  ---@type fun(self: table, key:string)
  scene.keyreleased = function(self, key)
    if args.keybindings[key] then
      args.keybindings[key]:press()
    end
  end

  return scene
end

return create_scene
