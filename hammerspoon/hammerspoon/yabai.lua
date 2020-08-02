local module = {}
local yabaiExec = "/usr/local/bin/yabai "
module.init = function()
end


module.cons = {};
module.fns = {};
module.cons.direction = {
   left=0,
   right=1,
   up=2,
   down=3,
   recent=4,
   stackprev=5,
   stacknext=6,
}

local execute = function(command)
   os.execute(command)
end

-- Move focus direction=>left, write, up, down
module.fns.moveFocus = function(direction)
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --focus west",
      [module.cons.direction.right]     = yabaiExec .. "-m window --focus east",
      [module.cons.direction.up]        = yabaiExec .. "-m window --focus north",
      [module.cons.direction.down]      = yabaiExec .. "-m window --focus south",
      [module.cons.direction.recent]    = yabaiExec .. "-m window --focus recent",
      [module.cons.direction.stackprev] = yabaiExec .. "-m window --focus stack.prev",
      [module.cons.direction.stacknext] = yabaiExec .. "-m window --focus stack.next",
   }
   if (not directions[direction]) then
      return
   end
   execute(directions[direction])
end

module.fns.swapWindows = function(direction)
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --swap west",
      [module.cons.direction.right]     = yabaiExec .. "-m window --swap east",
      [module.cons.direction.up]        = yabaiExec .. "-m window --swap north",
      [module.cons.direction.down]      = yabaiExec .. "-m window --swap south",
      [module.cons.direction.recent]    = yabaiExec .. "-m window --swap recent",
      [module.cons.direction.stackprev] = yabaiExec .. "-m window --swap stack.prev",
      [module.cons.direction.stacknext] = yabaiExec .. "-m window --swap stack.next"
   }
   if (not directions[direction]) then
      return
   end
   execute(directions[direction])
end


module.fns.moveWindows = function(direction)
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --warp west",
      [module.cons.direction.right]     = yabaiExec .. "-m window --warp east",
      [module.cons.direction.up]        = yabaiExec .. "-m window --warp north",
      [module.cons.direction.down]      = yabaiExec .. "-m window --warp south",
   }
   if (not directions[direction]) then
      return
   end
   execute(directions[direction])
end


module.fns.shiftFloatingWindows = function(direction, length)
   if length <= 0 then
      length = 100
   end
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --move rel:-"..length..":0",
      [module.cons.direction.right]     = yabaiExec .. "-m window --move rel:"..length.."0",
      [module.cons.direction.up]        = yabaiExec .. "-m window --move rel:0:-"..length,
      [module.cons.direction.down]      = yabaiExec .. "-m window --move rel:0:"..length,
   }
   if (not directions[direction]) then
      return
   end
   execute(directions[direction])
end


module.fns.moveToWorkspace = function(workspaceId)
   execute(yabaiExec .. "-m space --focus " .. workspaceId)
end

return module
