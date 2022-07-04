local env = {}
assert(pcall(setfenv(assert(loadstring(unpack(ARGV))), env)))
return cmsgpack.pack(env)
