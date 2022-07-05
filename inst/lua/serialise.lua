local is = {}

function is.identifier(str)
  return string.find(str, "^[%a_][%w_]*$") ~= nil
end

function is.array(indexed)
  local index = 0
  for _ in pairs(indexed) do
    index = index + 1
    if indexed[index] == nil then return false end
  end
  return true
end

local by = {}

function by.group(values, indexforvalue)
  local groups = {}
  for _, value in ipairs(values) do
    local index = indexforvalue(value)
    local group = groups[index]
    if group then table.insert(group, value)
    else groups[index] = {value} end
  end
  return groups
end

local unwrap = {}

function unwrap.first(...)
  local firsts = {}
  for first in ... do
    table.insert(firsts, first)
  end
  return firsts
end

local serialise = {}

local function indentindex(index, indent)
  return (indent or "")..(index or "")..(index and " = " or "")
end

local function anytostring(value, index, indent)
  return indentindex(index, indent)..tostring(value)
end

function serialise.any(value, index, indent, offset)
  local serialising = serialise[type(value)]
  return serialising and serialising(value, index, indent, offset) or "nil"
end

serialise.number = anytostring

serialise.boolean = anytostring

function serialise.string(value, index, indent)
  return indentindex(index, indent)..string.format("%q", value)
end

local function indexchunk(index)
  local isindex = "string" == type(index) and is.identifier(index)
  return isindex and index or "["..serialise.any(index).."]"
end

function serialise.table(value, index, indent, offset)
  indent = indent or ""
  offset = offset or "\t"
  local chunks = {}
  if is.array(value) then
    for _, value in ipairs(value) do
      table.insert(chunks, serialise.any(value, nil, indent..offset, offset))
    end
  else
    local function sort(indices)
      table.sort(indices)
      for _, index in ipairs(indices) do
        table.insert(chunks, serialise.any(value[index], indexchunk(index), indent..offset, offset))
      end
    end
    local indices = by.group(unwrap.first(pairs(value)), function(index)
        return type(index)
      end)
    if indices.number then sort(indices.number) end
    if indices.string then sort(indices.string) end
  end
  local chunk = indentindex(index, indent).."{"
  if #chunks > 0 then
    chunk = chunk.."\n"..table.concat(chunks, ",\n").."\n"..indent
  end
  return chunk.."}"
end

local keys = {
  GET = function(arg)
    return redis.call("GET", arg)
  end,
  STRUCT = function(arg)
    return struct.unpack(arg)
  end,
  CJSON = function(arg)
    return cjson.decode(arg)
  end,
  CMSGPACK = function(arg)
    return cmsgpack.unpack(arg)
  end,
  SERIALISE = function(arg, key)
    return serialise.any(arg, key)
  end,
  LOADSTRING = function(arg)
    local env = {}
    setfenv(assert(loadstring(arg)), env)()
    return env
  end
}

local results = {}

for _, arg in ipairs(ARGV) do
  local args = {arg}
  for _, key in ipairs(KEYS) do
    local calling = keys[key]
    if calling then args = {calling(unpack(args))}
    else table.insert(args, key) end
  end
  table.insert(results, args[1])
end

return #results == 1 and results[1] or results
