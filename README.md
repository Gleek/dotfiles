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


### Adding a new config
```
mkdir -p $1/$1 && mv ~/.config/$1/* $1/$1/. && rm -r ~/.config/$1 && stow -t ~/.config $1
```
