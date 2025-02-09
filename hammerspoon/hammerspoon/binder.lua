-- Bind directly to shell commands
local module = {}
local log = hs.logger.new('binder', 'debug');
local hotkey = require('hs.hotkey')
local exec = {
   kitty = "/opt/homebrew/bin/kitty ",
   yabai = "/opt/homebrew/bin/yabai ",
   mpv = "/opt/homebrew/bin/mpv ",
   emacsclient="/opt/homebrew/bin/emacsclient ",
}


module.bindFns = function()
   local y = require('yabai')
   -- local f = require('fns')
   local console = require('hs.console')
   local bindings = {
      {"cmd-shift-ctrl", "r", function() hs.reload() end},
      -- {"cmd-shift-ctrl", "i", function() hs.redshift.toggleInvert() end},
      {"cmd-shift-ctrl", "g", function() console.clearConsole() end},

      -----------
      -- Yabai --
      -----------
      -- {"alt", "tab", function() y.moveFocusRecent() end},
      -- {"alt", "b",   function() y.moveFocusLeft() end},
      -- {"alt", "n",   function() y.moveFocusDown() end},
      -- {"alt", "p",   function() y.moveFocusUp() end},
      -- {"alt", "f",   function() y.moveFocusRight() end},

      {"cmd-alt", "left",  function() y.swapWindowsLeft() end},
      {"cmd-alt", "right", function() y.swapWindowsRight() end},
      {"cmd-alt", "up",    function() y.swapWindowsUp() end},
      {"cmd-alt", "down",  function() y.swapWindowsDown() end},

      {"alt", "left",  function() y.moveWindowsLeft() end},
      {"alt", "right", function() y.moveWindowsRight() end},
      {"alt", "up",    function() y.moveWindowsUp() end},
      {"alt", "down",  function() y.moveWindowsDown() end},

      {"alt", "1", function() y.moveToWorkspace("s1") end},
      {"alt", "2", function() y.moveToWorkspace("s2") end},
      {"alt", "3", function() y.moveToWorkspace("s3") end},
      {"alt", "4", function() y.moveToWorkspace("s4") end},
      {"alt", "5", function() y.moveToWorkspace("s5") end},
      {"alt", "6", function() y.moveToWorkspace("s6") end},
      {"alt", "7", function() y.moveToWorkspace("s7") end},
      {"alt", "8", function() y.moveToWorkspace("s8") end},
      {"alt", "9", function() y.moveToWorkspace("s9") end},
      {"alt", "0", function() y.moveToWorkspace("s10") end},

      {"shift-alt", "1", function() y.moveWindowToWorkspace("s1") end},
      {"shift-alt", "2", function() y.moveWindowToWorkspace("s2") end},
      {"shift-alt", "3", function() y.moveWindowToWorkspace("s3") end},
      {"shift-alt", "4", function() y.moveWindowToWorkspace("s4") end},
      {"shift-alt", "5", function() y.moveWindowToWorkspace("s5") end},
      {"shift-alt", "6", function() y.moveWindowToWorkspace("s6") end},
      {"shift-alt", "7", function() y.moveWindowToWorkspace("s7") end},
      {"shift-alt", "8", function() y.moveWindowToWorkspace("s8") end},
      {"shift-alt", "9", function() y.moveWindowToWorkspace("s9") end},
      {"shift-alt", "0", function() y.moveWindowToWorkspace("s10") end},

      {"ctrl-alt", "down", function() y.moveSpaceToDisplay(1) end},
      {"ctrl-alt", "left", function() y.moveSpaceToDisplay(2) end},
      {"ctrl-alt", "up", function() y.moveSpaceToDisplay(3) end},

      {"shift-alt", "left" , function() y.shiftFloatingLeft() end},
      {"shift-alt", "down" , function() y.shiftFloatingDown() end},
      {"shift-alt", "up"   , function() y.shiftFloatingUp() end},
      {"shift-alt", "right", function() y.shiftFloatingRight() end},

      {"alt",        "a", function() y.toggleGaps() end},
      {"alt",        "e", function() y.toggleSplit() end},
      {"alt-shift",  "r", function() y.rotateWindows() end},
      {"alt",        "z", function() y.zoom() end},
      {"shift-alt",  "z", function() y.fullScreen() end},
      {"alt",        "t", function() y.togglePopup() end},
      {"alt",        "s", function() y.toggleLayout() end},


      {"alt",        "l", function() hs.caffeinate.lockScreen() hs.caffeinate.systemSleep() end},

      -- {"alt", "x", function() f.choose() end},
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
      {"alt-shift", "f"     , exec.kitty .. "--single-instance -d ~ ranger"                                                       , true},
      {"alt"      , "return", exec.kitty .. "--single-instance -d ~ -T floating-term screen -dR session"                          , "full"},
      {"shift-alt", "t"     , exec.kitty .. "--single-instance -d ~"},
      {"alt"      , "k"     , "open -a KeePassXC"},
      {"alt"      , "v"     , "open -a Maccy"},
      {"alt-shift", "e"     , exec.emacsclient .. "--eval \"(emacs-everywhere)\""},
      {"alt"      , "\\"    , exec.kitty .. "--single-instance gotop"                                                             , true},
      {"alt-shift", "m"     , exec.mpv .. "$(pbpaste)"},
      -- {"alt"      , "d"     , "export INTERFACE=TUI && /Users/umar/.config/choose/init /Users/umar/.config/choose/options.sh"     , true},
      -- {"alt"      , "d"     , "~/.config/emacs/scripts/launch.sh", "full"},
      {"alt"      , "d"     , exec.emacsclient .. "-s \"server\" -e \"(+launch-default-launcher)\""},
      {"alt"      , "x"     , "export INTERFACE=TUI && /Users/umar/.config/choose/init /Users/umar/.config/choose/hammerspoon.sh" , true},
      -- {"alt"      , "b"     , "export INTERFACE=TUI && /Users/umar/.config/choose/init /Users/umar/.config/choose/qute.sh"        , true},
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
          {'', 'left', function() y.increaseSizeLeft() end},
          {'', 'right', function() y.increaseSizeRight() end},
          {'', 'up', function() y.increaseSizeUp() end},
          {'', 'down', function() y.increaseSizeDown() end},
          {'shift', 'left', function() y.decreaseSizeLeft() end},
          {'shift', 'right', function() y.decreaseSizeRight() end},
          {'shift', 'up', function() y.decreaseSizeUp() end},
          {'shift', 'down', function() y.decreaseSizeDown() end},
       }
      },

      -------------------------
      -- Annotations (HHANN) --
      -------------------------
      {"shift-alt", "a", "Annotation",
       {
          {'', 'c', function() ann.clear() end},
          {'', 't', function() ann.toggleAnnotating() end},
          {'', 'r', function() ann.changeToRed() end},
          {'', 'g', function() ann.changeToGreen() end},
          {'', 'b', function() ann.changeToBlue() end},
          {'', 'up', function() ann.increaseStrokeWidth() end},
          {'', 'down', function() ann.decreaseStrokeWidth() end},
       },
       function() ann.start() end,
       function() ann.exit() end
      }
   }


   for _, mode in pairs(modes) do
      local hk = hotkey.modal.new(mode[1], mode[2])
      local modalAlert = {}
      function hk:entered()
         if mode[5] then (mode[5])() end
         modalAlert = hs.alert.show(
            mode[3] .. " mode",
            {textSize=13, radius=0, textFont="Fira Code", atScreenEdge=2},
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
   -- Figure out a way to disable for emacs
   -- require('holdtoquit').bind()
end




return module
