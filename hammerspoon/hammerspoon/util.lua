local module = {}
module.exec = function(cmd, env)
   cmd = cmd .. " &"
   -- using /bin/bash instead of os.getenv("SHELL") as my default
   -- shell zsh is loaded with stuff that slows things down, which I
   -- don't need just to get a proper environment
   return os.execute(env and "/bin/bash"..[[ -l -i -c "]]..cmd..[["]] or cmd)
end
return module
