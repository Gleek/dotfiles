# Dotfiles

Symlinked dotfiles: `home/*` targets `$HOME`; every other package targets `${XDG_CONFIG_HOME:-$HOME/.config}`.

```sh
git clone --recurse-submodules <repository-url> ~/Development/config
cd ~/Development/config
./dots.sh check
./dots.sh install

./dots.sh adopt alacritty
./dots.sh adopt --home .gitconfig
```
