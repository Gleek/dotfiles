-- Bind directly to shell commands
local module = {}
local log = hs.logger.new('binder', 'debug');
local hotkey = require('hs.hotkey')
local exec = {
   kitty = "/usr/local/bin/kitty ",
   yabai = "/usr/local/bin/yabai ",
   copyq = "/usr/local/bin/copyq ",
}


module.bindFns = function()
   local y = require('yabai')
   local console = require('hs.console')
   local bindings = {
      {"cmd-shift-ctrl", "r", function() hs.reload() end},
      {"cmd-shift-ctrl", "g", function() console.clearConsole() end},

      -----------
      -- Yabai --
      -----------
      {"alt", "tab", function() y.fns.moveFocus(y.cons.direction.recent) end},
      {"alt", "b",   function() y.fns.moveFocus(y.cons.direction.left) end},
      {"alt", "n",   function() y.fns.moveFocus(y.cons.direction.down) end},
      {"alt", "p",   function() y.fns.moveFocus(y.cons.direction.up) end},
      {"alt", "f",   function() y.fns.moveFocus(y.cons.direction.right) end},

      {"cmd-alt", "left",  function() y.fns.swapWindows(y.cons.direction.left) end},
      {"cmd-alt", "right", function() y.fns.swapWindows(y.cons.direction.right) end},
      {"cmd-alt", "up",    function() y.fns.swapWindows(y.cons.direction.up) end},
      {"cmd-alt", "down",  function() y.fns.swapWindows(y.cons.direction.down) end},

      {"alt", "left",  function() y.fns.moveWindows(y.cons.direction.left) end},
      {"alt", "right", function() y.fns.moveWindows(y.cons.direction.right) end},
      {"alt", "up",    function() y.fns.moveWindows(y.cons.direction.up) end},
      {"alt", "down",  function() y.fns.moveWindows(y.cons.direction.down) end},

      {"alt", "1", function() y.fns.moveToWorkspace(1) end},
      {"alt", "2", function() y.fns.moveToWorkspace(2) end},
      {"alt", "3", function() y.fns.moveToWorkspace(3) end},
      {"alt", "4", function() y.fns.moveToWorkspace(4) end},
      {"alt", "5", function() y.fns.moveToWorkspace(5) end},
      {"alt", "6", function() y.fns.moveToWorkspace(6) end},
      {"alt", "7", function() y.fns.moveToWorkspace(7) end},
      {"alt", "8", function() y.fns.moveToWorkspace(8) end},
      {"alt", "9", function() y.fns.moveToWorkspace(9) end},
      {"alt", "0", function() y.fns.moveToWorkspace(10) end},

      {"shift-alt", "1", function() y.fns.moveWindowToWorkspace(1) end},
      {"shift-alt", "2", function() y.fns.moveWindowToWorkspace(2) end},
      {"shift-alt", "3", function() y.fns.moveWindowToWorkspace(3) end},
      {"shift-alt", "4", function() y.fns.moveWindowToWorkspace(4) end},
      {"shift-alt", "5", function() y.fns.moveWindowToWorkspace(5) end},
      {"shift-alt", "6", function() y.fns.moveWindowToWorkspace(6) end},
      {"shift-alt", "7", function() y.fns.moveWindowToWorkspace(7) end},
      {"shift-alt", "8", function() y.fns.moveWindowToWorkspace(8) end},
      {"shift-alt", "9", function() y.fns.moveWindowToWorkspace(9) end},
      {"shift-alt", "0", function() y.fns.moveWindowToWorkspace(10) end},

      {"shift-alt", "left" , function() y.fns.shiftFloatingWindows(y.cons.direction.left) end},
      {"shift-alt", "down" , function() y.fns.shiftFloatingWindows(y.cons.direction.down) end},
      {"shift-alt", "up"   , function() y.fns.shiftFloatingWindows(y.cons.direction.up) end},
      {"shift-alt", "right", function() y.fns.shiftFloatingWindows(y.cons.direction.right) end},

      {"alt",        "a", function() y.fns.toggleGaps() end},
      {"alt",        "e", function() y.fns.toggleSplit() end},
      {"alt",        "r", function() y.fns.rotateWindows() end},
      {"alt",        "y", function() y.fns.mirrorY() end},
      {"alt",        "x", function() y.fns.mirrorX() end},
      {"alt",        "z", function() y.fns.zoom() end},
      {"shift-alt",  "z", function() y.fns.fullScreen() end},
      {"alt",        "t", function() y.fns.togglePopup() end},
      {"alt",        "s", function() y.fns.toggleLayout() end},
   }
   for _, binding in pairs(bindings) do
      hotkey.bind(binding[1], binding[2], binding[3])
   end
end

module.bindShell = function()
   local util = require('util')

   -- {keySeq}, key, command, env = true / "full"/ nil
   local bindings = {
      ------------------
      -- Applications --
      ------------------
      {"alt-shift", "f", exec.kitty .. "--single-instance -d ~ ranger", true},
      {"alt", "return", exec.kitty .. "--single-instance -d ~ -T floating-term screen -dR session", "full"},
      {"shift-alt", "t", exec.kitty .. "--single-instance -d ~"},
      {"alt", "k", "open -a KeePassXC"},
      {"alt", "v", exec.copyq .. "show"},
      {"alt", "\\", exec.kitty .. "--single-instance gotop", true},
      {"alt", "d",  "export INTERFACE=TUI && /Users/umar/.config/choose/init /Users/umar/.config/choose/options.sh", true},
   }
   for _, binding in pairs(bindings) do
      hotkey.bind(
         binding[1],
         binding[2],
         function()
            util.exec(binding[3], binding[4])
      end)
   end
end


module.bindModal = function()
   local y = require('yabai')
   local ann = require('hhann')
   -- modifier, key, mode-name, table of bindings, [init fn], [exit fn]
   local modes = {
      ------------------
      -- Yabai resize --
      ------------------
      {"alt", "r", "Resize" ,
       {
          {'', 'left', function() y.fns.resize(y.cons.direction.left, -20) end},
          {'', 'right', function() y.fns.resize(y.cons.direction.right, 20) end},
          {'', 'up', function() y.fns.resize(y.cons.direction.up, -20) end},
          {'', 'down', function() y.fns.resize(y.cons.direction.down, 20) end},
          {'shift', 'left', function() y.fns.resize(y.cons.direction.right, -20) end},
          {'shift', 'right', function() y.fns.resize(y.cons.direction.left, 20) end},
          {'shift', 'up', function() y.fns.resize(y.cons.direction.down, -20) end},
          {'shift', 'down', function() y.fns.resize(y.cons.direction.up, 20) end},
       }
      },

      -------------------------
      -- Annotations (HHANN) --
      -------------------------
      {"shift-alt", "a", "Annotation",
       {
          {'', 'c', function() ann.clear() end},
          {'', 't', function() ann.toggleAnnotating() end}
       },
       function() ann.start() ann.startAnnotating() end,
       function() ann.stopAnnotating() ann.hide() end
      }
   }


   for _, mode in pairs(modes) do
      local hk = hotkey.modal.new(mode[1], mode[2])
      local modalAlert = {}
      function hk:entered()
         if mode[5] then (mode[5])() end
         modalAlert = hs.alert.show(
            mode[3] .. " mode",
            {textSize=12, radius=0, textFont="Fira Mono", atScreenEdge=2},
            hs.screen.mainScreen(),
            "inf"
         )
      end
      function hk:exited()
         if mode[6] then (mode[6])() end
         hs.alert.closeSpecific(modalAlert)
      end
      hk:bind('', 'escape', function() hk:exit() end)
      for _, binding in pairs(mode[4]) do
         hk:bind(binding[1], binding[2], binding[3])
      end
   end
end

module.bindKeys = function()
   module.bindFns()
   module.bindShell()
   module.bindModal()
end




return module
