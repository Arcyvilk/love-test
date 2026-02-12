local fs = {
  write = function(filename, table_to_save)
    local file = love.filesystem.read("./" .. filename)
    print(file)
    love.filesystem.write(filename, table.concat(table_to_save, '\n'))
  end,

  read = function(filename)
    if not love.filesystem.getInfo("./" .. filename) then
      return nil
    end

    local contents = love.filesystem.read("./" .. filename)
    print(contents)
  end
}

return fs
