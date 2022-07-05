local env = {}
assert(pcall(setfenv(assert(loadstring(unpack(ARGV))), env)))
return "X\n\0"..cmsgpack.pack(env)
