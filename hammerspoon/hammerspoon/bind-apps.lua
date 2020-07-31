-- Bind directly to shell commands
local module = {}
local log = hs.logger.new('binder', 'debug');
local hotkey = require('hs.hotkey')
local exec = {
   kitty = "/usr/local/bin/kitty ",
   yabai = "/usr/local/bin/yabai ",
   copyq = "/usr/local/bin/copyq ",
   choose = "bash " .. os.getenv("HOME") .. "/.config/choose/init "
}
local bindings = {
   -----------
   -- Yabai --
   -----------

   -- focus windows
   {{"alt"}, "tab", exec.yabai .. "-m window --focus recent"},
   {{"alt"}, "b", exec.yabai .. "-m window --focus west"},
   {{"alt"}, "n", exec.yabai .. "-m window --focus south"},
   {{"alt"}, "p", exec.yabai .. "-m window --focus north"},
   {{"alt"}, "f", exec.yabai .. "-m window --focus east"},

   -- shift floating windows
   {{"shift", "alt"}, "left", exec.yabai..  "-m window --move rel:-100:0"},
   {{"shift", "alt"}, "down", exec.yabai..  "-m window --move rel:0:100"},
   {{"shift", "alt"}, "up", exec.yabai..  "-m window --move rel:0:-100"},
   {{"shift", "alt"}, "right", exec.yabai..  "-m window --move rel:100:0"},

   -- fast focus desktop
   {{"alt"}, "1", exec.yabai ..  "-m space --focus  1"},
   {{"alt"}, "2", exec.yabai ..  "-m space --focus  2"},
   {{"alt"}, "3", exec.yabai ..  "-m space --focus  3"},
   {{"alt"}, "4", exec.yabai ..  "-m space --focus  4"},
   {{"alt"}, "5", exec.yabai ..  "-m space --focus  5"},
   {{"alt"}, "6", exec.yabai ..  "-m space --focus  6"},
   {{"alt"}, "7", exec.yabai ..  "-m space --focus  7"},
   {{"alt"}, "8", exec.yabai ..  "-m space --focus  8"},
   {{"alt"}, "9", exec.yabai ..  "-m space --focus  9"},
   {{"alt"}, "0", exec.yabai ..  "-m space --focus 10"},


   {{"shift", "alt"}, "1", exec.yabai .. "-m window --space  1 && ".. exec.yabai .. "-m space --focus 1"},
   {{"shift", "alt"}, "2", exec.yabai .. "-m window --space  2 && ".. exec.yabai .. "-m space --focus 2"},
   {{"shift", "alt"}, "3", exec.yabai .. "-m window --space  3 && ".. exec.yabai .. "-m space --focus 3"},
   {{"shift", "alt"}, "4", exec.yabai .. "-m window --space  4 && ".. exec.yabai .. "-m space --focus 4"},
   {{"shift", "alt"}, "5", exec.yabai .. "-m window --space  5 && ".. exec.yabai .. "-m space --focus 5"},
   {{"shift", "alt"}, "6", exec.yabai .. "-m window --space  6 && ".. exec.yabai .. "-m space --focus 6"},
   {{"shift", "alt"}, "7", exec.yabai .. "-m window --space  7 && ".. exec.yabai .. "-m space --focus 7"},
   {{"shift", "alt"}, "8", exec.yabai .. "-m window --space  8 && ".. exec.yabai .. "-m space --focus 8"},
   {{"shift", "alt"}, "9", exec.yabai .. "-m window --space  9 && ".. exec.yabai .. "-m space --focus 9"},
   {{"shift", "alt"}, "0", exec.yabai .. "-m window --space 10 && ".. exec.yabai .. "-m space --focus 10"},

   ------------------
   -- Applications --
   ------------------
   {{"alt", "shift"}, "f", exec.kitty .. "--single-instance -d ~ ranger"},
   {{"alt"}, "return", exec.kitty .. "--single-instance -d ~ -T floating-term screen -dR session"},
   {{"shift", "alt"}, "t", exec.kitty .. "--single-instance -d ~"},
   {{"alt"}, "k", "open -a KeePassXC"},
   {{"alt"}, "v", exec.copyq .. "show"},
   {{"alt"}, "\\", exec.kitty .. "--single-instance gotop"},
   {{"alt"}, "d",  "export INTERFACE=TUI && /Users/umar/.config/choose/init /Users/umar/.config/choose/options.sh"},
}
local getKeyName = function(binding)
   return table.concat(binding[1], "-").. "-" .. binding[2]
end

os.execute('export INTERFACE=TUI && /Users/umar/.config/choose/init /Users/umar/.config/choose/options.sh')
module.bindKeys = function()
   for _, binding in pairs(bindings) do
      log.i(getKeyName(binding), binding[3])
      hotkey.bind(
         binding[1],
         binding[2],
         function()
            -- hs.alert.show(binding[3])
            os.execute(binding[3] .. " &")
      end)
   end
end




return module
