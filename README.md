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

### Adding a new config
```
mkdir -p $1/$1 && mv ~/.config/$1/* $1/$1/. && rm -r ~/.config/$1 && stow -t ~/.config $1
```

### TODO
- [ ] Move emacs here
