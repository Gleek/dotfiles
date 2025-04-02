export GOPATH="$HOME/Development/gocode"
export GOPRIVATE=$(echo "tvguho.pbz/Mbzngb/*"|tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
export GOOS=darwin
export GOARCH=arm64
export GOPATH="$HOME/Development/gocode"
# export
export LC_ALL=en_US.UTF-8 export LANG=en_US.UTF-8 export
# export PATH=""
export PATH="\
$HOME/.bin:\
/opt/homebrew/bin:\
/usr/local/opt/openjdk/bin:\
/usr/local/opt/coreutils/libexec/gnubin:\
/usr/local/opt/sqlite/bin:\
/usr/local/opt/php@7.4/bin:\
/usr/local/opt/php@7.4/sbin:\
/usr/local/bin:\
/usr/bin:\
/bin:\
/usr/sbin:\
/sbin:\
/usr/local/sbin:\
/opt/X11/bin:\
$GOPATH/bin:\
/usr/local/opt/php/bin:\
/usr/local/opt/fzf/bin:\
/Applications/dragger.app/Contents/MacOS:\
/Library/TeX/Distributions/Programs/texbin:\
"
if [ -f "$HOME/.zsh_secrets" ]; then
    source "$HOME/.zsh_secrets"
fi
