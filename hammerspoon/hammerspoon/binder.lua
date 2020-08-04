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
   local yabai = require('yabai')
   local console = require('hs.console')
   local bindings = {
      {"cmd-shift-ctrl", "r", function() hs.reload() end},
      {"cmd-shift-ctrl", "g", function() console.clearConsole() end},

      {"alt", "tab", function() yabai.fns.moveFocus(yabai.cons.direction.recent) end},
      {"alt", "b",   function() yabai.fns.moveFocus(yabai.cons.direction.left) end},
      {"alt", "n",   function() yabai.fns.moveFocus(yabai.cons.direction.down) end},
      {"alt", "p",   function() yabai.fns.moveFocus(yabai.cons.direction.up) end},
      {"alt", "f",   function() yabai.fns.moveFocus(yabai.cons.direction.right) end},

      {"cmd-alt", "left",  function() yabai.fns.swapWindows(yabai.cons.direction.left) end},
      {"cmd-alt", "right", function() yabai.fns.swapWindows(yabai.cons.direction.right) end},
      {"cmd-alt", "up",    function() yabai.fns.swapWindows(yabai.cons.direction.up) end},
      {"cmd-alt", "down",  function() yabai.fns.swapWindows(yabai.cons.direction.down) end},

      {"alt", "left",  function() yabai.fns.moveWindows(yabai.cons.direction.left) end},
      {"alt", "right", function() yabai.fns.moveWindows(yabai.cons.direction.right) end},
      {"alt", "up",    function() yabai.fns.moveWindows(yabai.cons.direction.up) end},
      {"alt", "down",  function() yabai.fns.moveWindows(yabai.cons.direction.down) end},
   }
   for _, binding in pairs(bindings) do
      hotkey.bind(binding[1], binding[2], binding[3])
   end
end

module.bindShell = function()
   local util = require('util')

   -- {keySeq}, key, command, fullEnvironment?
   local bindings = {
      -----------
      -- Yabai --
      -----------

      -- focus windows
      -- {"alt", "tab", exec.yabai .. "-m window --focus recent"},
      -- {"alt", "b", exec.yabai .. "-m window --focus west"},
      -- {"alt", "n", exec.yabai .. "-m window --focus south"},
      -- {"alt", "p", exec.yabai .. "-m window --focus north"},
      -- {"alt", "f", exec.yabai .. "-m window --focus east"},

      -- shift floating windows
      {"shift-alt", "left", exec.yabai..  "-m window --move rel:-100:0"},
      {"shift-alt", "down", exec.yabai..  "-m window --move rel:0:100"},
      {"shift-alt", "up", exec.yabai..  "-m window --move rel:0:-100"},
      {"shift-alt", "right", exec.yabai..  "-m window --move rel:100:0"},

      -- fast focus desktop
      {"alt", "1", exec.yabai ..  "-m space --focus  1"},
      {"alt", "2", exec.yabai ..  "-m space --focus  2"},
      {"alt", "3", exec.yabai ..  "-m space --focus  3"},
      {"alt", "4", exec.yabai ..  "-m space --focus  4"},
      {"alt", "5", exec.yabai ..  "-m space --focus  5"},
      {"alt", "6", exec.yabai ..  "-m space --focus  6"},
      {"alt", "7", exec.yabai ..  "-m space --focus  7"},
      {"alt", "8", exec.yabai ..  "-m space --focus  8"},
      {"alt", "9", exec.yabai ..  "-m space --focus  9"},
      {"alt", "0", exec.yabai ..  "-m space --focus 10"},


      {"shift-alt", "1", exec.yabai .. "-m window --space  1 && ".. exec.yabai .. "-m space --focus 1"},
      {"shift-alt", "2", exec.yabai .. "-m window --space  2 && ".. exec.yabai .. "-m space --focus 2"},
      {"shift-alt", "3", exec.yabai .. "-m window --space  3 && ".. exec.yabai .. "-m space --focus 3"},
      {"shift-alt", "4", exec.yabai .. "-m window --space  4 && ".. exec.yabai .. "-m space --focus 4"},
      {"shift-alt", "5", exec.yabai .. "-m window --space  5 && ".. exec.yabai .. "-m space --focus 5"},
      {"shift-alt", "6", exec.yabai .. "-m window --space  6 && ".. exec.yabai .. "-m space --focus 6"},
      {"shift-alt", "7", exec.yabai .. "-m window --space  7 && ".. exec.yabai .. "-m space --focus 7"},
      {"shift-alt", "8", exec.yabai .. "-m window --space  8 && ".. exec.yabai .. "-m space --focus 8"},
      {"shift-alt", "9", exec.yabai .. "-m window --space  9 && ".. exec.yabai .. "-m space --focus 9"},
      {"shift-alt", "0", exec.yabai .. "-m window --space 10 && ".. exec.yabai .. "-m space --focus 10"},

      ------------------
      -- Applications --
      ------------------
      {"alt-shift", "f", exec.kitty .. "--single-instance -d ~ ranger", true},
      {"alt", "return", exec.kitty .. "--single-instance -d ~ -T floating-term screen -dR session", true},
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
            util.exec(binding[3], not not binding[4])
      end)
   end
end

module.bindKeys = function()
   module.bindFns()
   module.bindShell()
end




return module
