local module = {}
local yabaiExec = "/opt/homebrew/bin/yabai "

local log = hs.logger.new('yabai', 'debug');
module.cons = {};
module.cons.direction = {
   left=0,
   right=1,
   up=2,
   down=3,
   recent=4,
   stackprev=5,
   stacknext=6,
}


module.interactives = {
   "moveFocusLeft", "moveFocusRight", "moveFocusUp", "moveFocusDown",
   "moveFocusRecent", "moveFocusStackPrev", "moveFocusStackNext",
   "swapWindowsLeft", "swapWindowsRight", "swapWindowsUp",
   "swapWindowsDown", "toggleGaps", "rotateWindows", "mirrorX",
   "mirrorY", "zoom", "fullScreen", "togglePopup", "toggleSplit",
   "toggleLayout", "toggleSticky", "toggleTopMost", "resetSpaces",
   "numberCurrentSpace", "organizeSpaces", "organizeApps", "organize"
 }


module.moveFocusLeft = function() module.moveFocus(module.cons.direction.left) end
module.moveFocusRight = function() module.moveFocus(module.cons.direction.right) end
module.moveFocusUp = function() module.moveFocus(module.cons.direction.up) end
module.moveFocusDown = function() module.moveFocus(module.cons.direction.down) end
module.moveFocusRecent = function() module.moveFocus(module.cons.direction.recent) end
module.moveFocusStackPrev = function() module.moveFocus(module.cons.direction.stackprev) end
module.moveFocusStackNext = function() module.moveFocus(module.cons.direction.stacknext) end

module.swapWindowsLeft = function() module.swapWindows(module.cons.direction.left) end
module.swapWindowsRight = function() module.swapWindows(module.cons.direction.right) end
module.swapWindowsUp = function() module.swapWindows(module.cons.direction.up) end
module.swapWindowsDown = function() module.swapWindows(module.cons.direction.down) end
module.swapWindowsRecent = function() module.swapWindows(module.cons.direction.recent) end
module.swapWindowsStackPrev = function() module.swapWindows(module.cons.direction.stackprev) end
module.swapWindowsStackNext = function() module.swapWindows(module.cons.direction.stacknext) end


module.moveWindowsLeft = function() module.moveWindows(module.cons.direction.left) end
module.moveWindowsRight = function() module.moveWindows(module.cons.direction.right) end
module.moveWindowsUp = function() module.moveWindows(module.cons.direction.up) end
module.moveWindowsDown = function() module.moveWindows(module.cons.direction.down) end

module.shiftFloatingLeft = function() module.shiftFloatingWindows(module.cons.direction.left) end
module.shiftFloatingRight = function() module.shiftFloatingWindows(module.cons.direction.right) end
module.shiftFloatingUp = function() module.shiftFloatingWindows(module.cons.direction.up) end
module.shiftFloatingDown = function() module.shiftFloatingWindows(module.cons.direction.down) end

module.increaseSizeLeft = function() module.resize(module.cons.direction.left, -20) end
module.increaseSizeRight = function() module.resize(module.cons.direction.right, 20) end
module.increaseSizeUp = function() module.resize(module.cons.direction.up, -20) end
module.increaseSizeDown = function() module.resize(module.cons.direction.down, 20) end

module.decreaseSizeLeft = function() module.resize(module.cons.direction.right, -20) end
module.decreaseSizeRight = function() module.resize(module.cons.direction.left, 20) end
module.decreaseSizeUp = function() module.resize(module.cons.direction.down, -20) end
module.decreaseSizeDown = function() module.resize(module.cons.direction.up, 20) end

-- Move focus direction=> takes in module.cons.direction as param
module.moveFocus = function(direction)
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

module.swapWindows = function(direction)
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


module.moveWindows = function(direction)
   local directions = {
      [module.cons.direction.left]      = yabaiExec .. "-m window --warp west",
      [module.cons.direction.right]     = yabaiExec .. "-m window --warp east",
      [module.cons.direction.up]        = yabaiExec .. "-m window --warp north",
      [module.cons.direction.down]      = yabaiExec .. "-m window --warp south",
   }
   if (not directions[direction]) then return end
   require('util').exec(directions[direction])
end


module.shiftFloatingWindows = function(direction, length)
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

module.resize = function(direction, length, abs)
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

-- local focusDisplayForSpace = function (spaceId)
--    local displayId = hs.json.decode((hs.execute(yabaiExec .. "-m query --spaces --space " .. spaceId)))["display"]
--    require('util').exec(yabaiExec .. "-m display --focus " .. displayId)
-- end


module.moveToWorkspace = function(workspaceId)
   -- focusDisplayForSpace(workspaceId) -- makes no difference it seems.
   require('util').exec(yabaiExec .. "-m space --focus " .. workspaceId)
end



module.moveWindowToWorkspace = function(workspaceId)
   workspaceId = workspaceId or "recent"
   -- focusDisplayForSpace(workspaceId)
   require('util').exec(yabaiExec .. "-m window --space " .. workspaceId)
end

module.moveSpaceToDisplay = function(displayId)
   require('util').exec(yabaiExec .. "-m space --display " .. displayId)
   -- Yabai requires a reload post display adjustment sometimes.
   -- require('util').exec("sleep 2 && sudo " .. yabaiExec .. "--load-sa")
end

module.moveSpaceIdToDisplay = function(displayId, workspaceId)
   require('util').exec(yabaiExec .. "-m space " .. workspaceId .. " --display " .. displayId)
   -- Yabai requires a reload post display adjustment sometimes.
   -- require('util').exec("sleep 2 && sudo " .. yabaiExec .. "--load-sa")
end

module.toggleGaps = function()
   require('util').exec(yabaiExec .. "-m space --toggle padding")
   require('util').exec(yabaiExec .. "-m space --toggle gap")
end

module.rotateWindows = function()
   require('util').exec(yabaiExec .. "-m space --rotate 90")
end

module.mirrorX = function()
   require('util').exec(yabaiExec .. "-m space --mirror x-axis")
end

module.mirrorY = function()
   require('util').exec(yabaiExec .. "-m space --mirror y-axis")
end

module.zoom = function()
   require('util').exec(yabaiExec .. "-m window --toggle zoom-fullscreen")
end

module.fullScreen = function()
   require('util').exec(yabaiExec .. "-m window --toggle native-fullscreen")
end

module.togglePopup = function()
   require('util').exec(yabaiExec .. "-m window --toggle float")
   require('util').exec(yabaiExec .. "-m window --grid 4:4:1:1:2:2")
end

module.toggleSplit = function()
   require('util').exec(yabaiExec .. "-m window --toggle split")
end

module.toggleSticky = function()
   require('util').exec(yabaiExec .. "-m window --toggle sticky")
end

module.toggleLayout = function()
   local layout = hs.json.decode((hs.execute(yabaiExec .. "-m query --spaces --space")))["type"]
   layout = layout== "bsp" and "float" or "bsp"
   require('util').exec(yabaiExec .. "-m space --layout " .. layout)
end

module.toggleTopMost = function()
   require('util').exec(yabaiExec .. "-m window --toggle topmost")
end

module.resetSpaces = function()
   for i = 1, 10 do
         require('util').exec(yabaiExec .. "-m space ".. i .. " --label s" .. i)
   end
end

module.numberCurrentSpace = function()
   local currentSpace = hs.json.decode((hs.execute(yabaiExec .. "-m query --spaces --space")))["index"]
   local button, text = hs.dialog.textPrompt(
      'Number Current Space',
      '',
      tostring(currentSpace)
   )
   if button == "OK" then
      require('util').exec(yabaiExec .. "-m space --label s" .. text)
   end
end

module.organizeSpaces = function()
   module.resetSpaces()
   -- check number of monitors
   local displays = #hs.json.decode((hs.execute(yabaiExec .. "-m query --displays")))
   local displayTable = {}
   if displays == 2 then
      displayTable = {
         [1] = {"s4", "s5", "s6", "s7", "s10"},
         [2] = {"s1", "s2", "s3", "s8", "s9"},
      }
   end
   if displays > 2 then
      displayTable = {
         [1] = {"s4", "s5", "s6", "s10"},
         [2] = {"s1", "s3", "s8"},
         [3] = {"s2", "s7", "s9"},
         -- I don't use over 3 displays.
      }
   end
   for display, spaces in pairs(displayTable) do
      log.i("Moving spaces to display " .. display)
      for _, space in ipairs(spaces) do
         log.i("Moving space " .. space .. " to display " .. display)
         module.moveSpaceIdToDisplay(display, space)
         -- sleep for some time to allow the space to move to the display.
         hs.timer.usleep(100000)
      end
   end
end

module.organizeApps = function()
   local apps = {
      ["Firefox"] = "s1",
      ["Emacs"] = "s2",
      ["kitty"] = "s3",
      ["Calendar"] = "s3",
      ["Slack"] = "s4",
      ["zoom.us"] = "s5",
      ["Whatsapp"] = "s6",
      ["Google Chrome"] = "s7"
   }
   for appn, space in pairs(apps) do
      -- app = module.focusApp(app)
      local app = hs.application.get(appn)
      if app then
         log.i("Moving app " .. appn .. " to space " .. space)
         app:activate()
         module.moveWindowToWorkspace(space)
      else
         log.i("App " .. appn .. " not found")
      end
      -- sleep for some time to allow the app to move to the workspace.
      hs.timer.usleep(100000)
   end
end

module.organize = function()
   module.organizeSpaces()
   module.organizeApps()
end


return module
