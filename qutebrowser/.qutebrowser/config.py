from os.path import expanduser
home = expanduser("~")
realbase = home + '/.qutebrowser/'
config.load_autoconfig()
config.source(realbase + 'qutemacs/qutemacs.py')
# config.source(realbase + 'themes/onedark.py')
config.set("fonts.default_family", "Jetbrains Mono")
config.set("fonts.default_size", "12pt")
config.set("tabs.show", "multiple")
config.set("tabs.last_close", "close")
config.set("content.javascript.can_access_clipboard", True)
config.set("content.javascript.can_open_tabs_automatically", True)

c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.input.insert_mode.plugins = True
c.input.insert_mode.auto_load = True
# Forward unbound keys
c.input.forward_unbound_keys = "all"

c.editor.command = ['/usr/local/bin/emacsclient', '+{line}:{column}', '{file}']
