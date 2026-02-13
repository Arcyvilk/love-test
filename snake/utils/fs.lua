local get_name = function(filename)
  return filename
end

local fs = {
  write = function(filename, table_to_save)
    local data_str = table.concat(table_to_save, ',') .. "|"

    local success = love.filesystem.append(get_name(filename), data_str)
    if success then print("Successfully saved!") end
  end,

  ---@param filename string
  ---@return string
  read = function(filename)
    if not love.filesystem.getInfo(get_name(filename)) then
      return ""
    end

    local contents_str = love.filesystem.read(get_name(filename))

    return contents_str or ""
  end
}

return fs
