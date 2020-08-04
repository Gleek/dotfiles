local module = {}
module.exec = function(cmd, env)
   cmd = cmd .. " &"
   local shell = env == "full" and os.getenv("SHELL") or "/bin/bash"
   -- /bin/bash with no settings is much faster than zsh with all the plugins
   -- hs.logger.new("", "debug").i("Running ".. cmd, env)
   return os.execute(env and shell..[[ -l -i -c "]]..cmd..[["]] or cmd)
end
return module
