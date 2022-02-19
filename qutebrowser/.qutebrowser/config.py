from os.path import expanduser
from os import environ
import subprocess

home = expanduser("~")
realbase = home + '/.qutebrowser/'
envfile = home + '/.zshenv'
environ['PATH'] = subprocess.check_output('source ' + envfile +
                                          ' && echo $PATH',
                                          shell=True,
                                          text=True)

config.load_autoconfig()
config.source(realbase + 'qutemacs/qutemacs.py')
themes = ['base16-onedark.config.py', 'base16-one-light.config.py']
config.source(realbase + 'themes/' + themes[0])
config.set("fonts.default_family", "Jetbrains Mono")
config.set("fonts.default_size", "13pt")
config.set("tabs.show", "multiple")
config.set("hints.mode", "number")
config.set("tabs.last_close", "close")
config.set("scrolling.bar", "always")
config.set("content.javascript.can_access_clipboard", True)
config.set("content.javascript.can_open_tabs_automatically", True)
# config.set("colors.webpage.darkmode.enabled", True)
c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.input.insert_mode.plugins = True
c.input.insert_mode.auto_load = True
# Forward unbound keys
c.input.forward_unbound_keys = "all"

c.editor.command = ['/usr/local/bin/emacsclient', '+{line}:{column}', '{file}']
