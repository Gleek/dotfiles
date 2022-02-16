# qutemacs - a simple, preconfigured Emacs binding set for qutebrowser
#
# The aim of this binding set is not to provide bindings for absolutely
# everything, but to provide a stable launching point for people to make their
# own bindings.
#
# Installation:
#
# 1. Copy this file or add this repo as a submodule to your dotfiles.
# 2. Add this line to your config.py, and point the path to this file:
# config.source('qutemacs/qutemacs.py')


config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

from os.path import expanduser
home = expanduser("~")
realbase = home + '/.qutebrowser/'


ESC_BIND = 'clear-keychain ;; search ;; fullscreen --leave'

c.bindings.default['normal'] = {}
# Bindings
c.bindings.commands['normal'] = {
    # Navigation
    '<ctrl-v>': 'scroll-page 0 0.9',
    '<meta-v>': 'scroll-page 0 -0.9',
    '<Backspace>': 'scroll-page 0 -0.9',
    # '<Space>': 'scroll-page 0 0.9',
    '<meta-shift-.>': 'scroll-to-perc',
    '<meta-shift-,>': 'scroll-to-perc 0',


    # Commands
    '<meta-x>': 'set-cmd-text :',
    '<meta-shift-;>': 'set-cmd-text :spawn --userscript ',
    '<ctrl-x><ctrl-c>': 'quit',

    # searching
    '<ctrl-s>': 'set-cmd-text /',
    '<ctrl-r>': 'set-cmd-text ?',

    # hinting
    '<f>': 'hint all',
    '<ctrl-u><f>': 'hint all hover',
    '<shift-f>': 'hint all tab-bg',
    '<ctrl-u><shift-e>': 'hint all tab-fg',
    '<w><l>': 'hint all yank-primary',
    '<w><w>': 'yank url',
    '<d>': 'yank all download',

    # history
    '<shift-f>': 'forward',
    '<shift-b>': 'back',
    '<ctrl-c><ctrl-f>': 'forward',
    '<ctrl-c><ctrl-b>': 'back',
    '<shift-h>': 'history',

    # bookmarks
    'm': 'bookmark-add',
    '<ctrl-u><m>': 'quickmark-save',
    'M': 'open qute://bookmarks',


    # tabs
    '<ctrl-tab>': 'tab-next',
    '<ctrl-shift-tab>': 'tab-prev',
    '<meta-n>': 'tab-next',
    '<shift-meta-n>': 'tab-move +',
    '<meta-p>': 'tab-prev',
    '<shift-meta-p>': 'tab-move -',
    '<ctrl-x><b>': 'set-cmd-text -s :tab-select ',
    '<ctrl-x><k>': 'tab-close',
    '<ctrl-c><p>': 'tab-pin',
    '<ctrl-c><m>': 'tab-mute',
    '<ctrl-x><0>': 'tab-close',
    '<ctrl-x><1>': 'tab-only',
    '<meta-1>': 'tab-focus 1',
    '<meta-2>': 'tab-focus 2',
    '<meta-3>': 'tab-focus 3',
    '<meta-4>': 'tab-focus 4',
    '<meta-5>': 'tab-focus 5',
    '<meta-6>': 'tab-focus 6',
    '<meta-7>': 'tab-focus 7',
    '<meta-8>': 'tab-focus 8',
    '<meta-9>': 'tab-focus -1',

    # frames
    '<ctrl-x><5><0>': 'close',
    '<ctrl-x><5><1>': 'window-only',
    '<ctrl-x><5><2>': 'set-cmd-text -s :open -w',
    '<ctrl-u><ctrl-x><5><2>': 'set-cmd-text -s :open -p',


    # open links
    '<g>': 'set-cmd-text -s :open',
    '<shift-g>': 'set-cmd-text -s :open -t',
    '<ctrl-u><g>': 'set-cmd-text :open {url:pretty}',

    # editing
    '<ctrl-f>': 'fake-key <Right>',
    '<ctrl-b>': 'fake-key <Left>',
    '<ctrl-a>': 'fake-key <Home>',
    '<ctrl-e>': 'fake-key <End>',
    '<ctrl-n>': 'fake-key <Down>',
    '<ctrl-p>': 'fake-key <Up>',
    '<meta-f>': 'fake-key <Ctrl-Right>',
    '<meta-b>': 'fake-key <Ctrl-Left>',
    '<ctrl-d>': 'fake-key <Delete>',
    '<meta-d>': 'fake-key <Ctrl-Delete>',
    '<meta-backspace>': 'fake-key <alt-Backspace>',
    # '<ctrl-w>': 'fake-key <Ctrl-backspace>',
    '<ctrl-y>': 'insert-text {primary}',
    '<ctrl-w>': 'fake-key <Meta-x>;;message-info "cut to clipboard"',
    '<alt-w>': 'fake-key <Meta-c>;;message-info "copy to clipboard"',

    # Numbers
    # https://github.com/qutebrowser/qutebrowser/issues/4213
    '1': 'fake-key 1',
    '2': 'fake-key 2',
    '3': 'fake-key 3',
    '4': 'fake-key 4',
    '5': 'fake-key 5',
    '6': 'fake-key 6',
    '7': 'fake-key 7',
    '8': 'fake-key 8',
    '9': 'fake-key 9',
    '0': 'fake-key 0',

    # misc
    # '<ctrl-c><v>': 'spawn --userscript ~/.bin/open_in_mpv.sh',
    '<ctrl-c><e>': ':jseval --file ' + realbase + 'js/eww.js',
    '<ctrl-c><c>': ':jseval --file ' + realbase +'js/capture.js',

    # modes
    '<ctrl-meta-escape>': 'mode-enter passthrough',
    '<ctrl-space>': 'mode-enter caret',

    # Help
    '<ctrl-h><b>': 'open qute://bindings',
    '<ctrl-h><h>': 'set-cmd-text -s :help',
    # escape hatch
    '<ctrl-g>': ESC_BIND,
}

c.bindings.commands['command'] = {
    '<ctrl-s>': 'search-next',
    '<ctrl-r>': 'search-prev',

    '<ctrl-p>': 'completion-item-focus prev',
    '<ctrl-n>': 'completion-item-focus next',

    '<meta-p>': 'command-history-prev',
    '<meta-n>': 'command-history-next',

    # escape hatch
    '<ctrl-g>': 'mode-leave',
}

c.bindings.commands['hint'] = {
    # escape hatch
    '<ctrl-g>': 'mode-leave',
}


c.bindings.commands['caret'] = {
    # escape hatch
    '<ctrl-g>': 'mode-leave',
    '<ctrl-f>': 'fake-key <l>',
    '<ctrl-b>': 'fake-key <h>',
    '<ctrl-a>': 'fake-key <0>',
    '<ctrl-e>': 'fake-key <$>',
    '<ctrl-n>': 'fake-key <j>',
    '<ctrl-p>': 'fake-key <k>'
}

c.bindings.commands['insert'] = {
    # editing
    '<ctrl-f>': 'fake-key <Right>',
    '<ctrl-b>': 'fake-key <Left>',
    '<ctrl-a>': 'fake-key <Home>',
    '<ctrl-e>': 'fake-key <End>',
    '<ctrl-n>': 'fake-key <Down>',
    '<ctrl-p>': 'fake-key <Up>',
    '<meta-f>': 'fake-key <Ctrl-Right>',
    '<meta-b>': 'fake-key <Ctrl-Left>',
    '<ctrl-d>': 'fake-key <Delete>',
    '<meta-d>': 'fake-key <Ctrl-Delete>',
    '<meta-backspace>': 'fake-key <Ctrl-Backspace>',
    '<ctrl-w>': 'fake-key <Ctrl-backspace>',
    '<ctrl-y>': 'insert-text {primary}',
    '<ctrl-g>': 'mode-leave'
}
