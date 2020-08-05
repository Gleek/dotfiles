local module = {}
local yabaiExec = "/usr/local/bin/yabai "
module.init = function()
end

-- local log = hs.logger.new('yabai', 'debug');
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


-- Move focus direction=> takes in module.cons.direction as param
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
   if (not directions[direction]) then return end
   require('util').exec(directions[direction])
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
   if (not directions[direction]) then return end
   require('util').exec(directions[direction])
end


module.fns.moveWindows = function(direction)
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --warp west",
      [module.cons.direction.right]     = yabaiExec .. "-m window --warp east",
      [module.cons.direction.up]        = yabaiExec .. "-m window --warp north",
      [module.cons.direction.down]      = yabaiExec .. "-m window --warp south",
   }
   if (not directions[direction]) then return end
   require('util').exec(directions[direction])
end


module.fns.shiftFloatingWindows = function(direction, length)
   length = length or 100
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --move rel:-"..length..":0",
      [module.cons.direction.right]     = yabaiExec .. "-m window --move rel:"..length..":0",
      [module.cons.direction.up]        = yabaiExec .. "-m window --move rel:0:-"..length,
      [module.cons.direction.down]      = yabaiExec .. "-m window --move rel:0:"..length,
   }
   if (not directions[direction]) then return end
   require('util').exec(directions[direction])
end

module.fns.resize = function(direction, length, abs)
   abs = abs and "abs" or 0
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --resize left:"..length..":"..abs,
      [module.cons.direction.right]     = yabaiExec .. "-m window --resize right:"..length..":"..abs,
      [module.cons.direction.up]        = yabaiExec .. "-m window --resize top:"..abs..":"..length,
      [module.cons.direction.down]      = yabaiExec .. "-m window --resize bottom:"..abs..":".. length,
   }
   if (not directions[direction]) then return end
   require('util').exec(directions[direction])
end


module.fns.moveToWorkspace = function(workspaceId)
   require('util').exec(yabaiExec .. "-m space --focus " .. workspaceId)
end

module.fns.moveWindowToWorkspace = function(workspaceId)
   workspaceId = workspaceId or "recent"
   require('util').exec(yabaiExec .. "-m window --space " .. workspaceId)
end

module.fns.toggleGaps = function()
   require('util').exec(yabaiExec .. "-m space --toggle padding")
   require('util').exec(yabaiExec .. "-m space --toggle gap")
end

module.fns.rotateWindows = function()
   require('util').exec(yabaiExec .. "-m space --rotate 90")
end

module.fns.mirrorX = function()
   require('util').exec(yabaiExec .. "-m space --mirror x-axis")
end

module.fns.mirrorY = function()
   require('util').exec(yabaiExec .. "-m space --mirror y-axis")
end

module.fns.zoom = function()
   require('util').exec(yabaiExec .. "-m window --toggle zoom-fullscreen")
end

module.fns.fullScreen = function()
   require('util').exec(yabaiExec .. "-m window --toggle native-fullscreen")
end

module.fns.togglePopup = function()
   require('util').exec(yabaiExec .. "-m window --toggle float")
   require('util').exec(yabaiExec .. "-m window --grid 4:4:1:1:2:2")
end

module.fns.toggleSplit = function()
   require('util').exec(yabaiExec .. "-m window --toggle split")
end

module.fns.toggleLayout = function()
   local layout = hs.json.decode((hs.execute(yabaiExec .. "-m query --spaces --space")))["type"]
   layout = layout== "bsp" and "float" or "bsp"
   require('util').exec(yabaiExec .. "-m space --layout " .. layout)
end

return module
