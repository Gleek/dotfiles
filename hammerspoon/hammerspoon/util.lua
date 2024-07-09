local module = {}
module.exec = function(cmd, env)
   cmd = cmd .. " &"
   local shell = env == "full" and os.getenv("SHELL") or "/bin/bash"
   -- /bin/bash with no settings is much faster than zsh with all the plugins
   local fcmd = env and shell.." -l -i -c "..("%q"):format(cmd) or cmd
   -- hs.logger.new("cmd", "debug").i("Running ", fcmd)
   return os.execute(fcmd)
end
return module
