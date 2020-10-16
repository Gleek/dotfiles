Dotfiles
--------
Generated using

```
stow -t ~ zshrc
stow -t ~ xresources
stow -t ~/.config i3
stow -t ~/.config mpd
stow -t ~/.config mpDris2
stow -t ~/.config newsboat
stow -t ~/.config ranger
stow -t ~/.config rofi
stow -t ~/.config polybar
stow -t ~/.config kitty
```
Similarly for others

I recently switched to macos from linux. Many of the applications work on both the platforms but they would have first class support on a mac.

Linux(X) specific applications should work but won't be updated.

I also try to stay inside Emacs as much as possible, which means I'll stop using all the other applications completely and everything will be replaced by emacs sooner or later

Some replacements that have already happened or are in process and won't be tweaked further
- Ranger: Dired
- i3: exwm (sadly not on macos)
- mpd: bongo
- kitty: vterm/eshell
- newsboat: elfeed

### Adding a new config
`./generator.sh directory`
