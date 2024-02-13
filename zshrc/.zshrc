# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/umar/.oh-my-zsh"
DISABLE_AUTO_UPDATE="true"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git screen)

source $ZSH/oh-my-zsh.sh

# User configuration


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# pFor a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
# alias e='emacsclient -nw'
e() { emacsclient "$@" & }
remoteworkpath=$(echo "/ine/jjj/mbzngb9"|tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
zpath=$(echo "~/Qrirybczrag/mbzngb/nccyvpngvba"| tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
alias ec=emacsclient
alias eprofile='emacs -Q -l ~/.emacs.d/profile-dotemacs.el -f profile-dotemacs'
alias zmount="sshfs zdev:$remoteworkpath $zpath -oauto_cache,reconnect,Ciphers=arcfour,Compression=no"
alias zrmount="sshfs zdevr:$remoteworkpath $zpath -oauto_cache,reconnect,Ciphers=arcfour,Compression=no"
alias zpmount='sshfs zdev:/var/www/Payments ~/Development/zpayments -oauto_cache,reconnect,Ciphers=arcfour,Compression=no'
alias zprmount='sshfs zdevr:/var/www/Payments ~/Development/zpayments -oauto_cache,reconnect,Ciphers=arcfour,Compression=no'
alias zumount='sudo umount $zpath'

alias ncdu='ncdu --color dark'

alias startzsync="unison default $zpath ssh://zdev/$remoteworkpath/application/ -repeat watch -times  -logfile /tmp/unison.log"
alias startzrsync="unison default $zpath ssh://zdevr/$remoteworkpath/application/ -repeat watch -times  -logfile /tmp/unison.log"
alias startzpoll="unison default $zpath ssh://zdev/$remoteworkpath/application/ -repeat 2 -watch=false  -logfile /tmp/unison.log"
alias startzrpoll="unison default $zpath ssh://zdevr/$remoteworkpath/application/ -repeat 2 -watch=false -prefer $zpath -logfile /tmp/unison.log"
alias startfzpoll="unison default $zpath ssh://zdev/$remoteworkpath/application/ -repeat 2 -watch=false -prefer $zpath -logfile /tmp/unison.log"
alias startfzrpoll="unison default $zpath ssh://zdevr/$remoteworkpath/application/ -repeat 2 -watch=false  -logfile /tmp/unison.log"
alias zremotesync="unison -batch -times $zpath ssh://zdev/$remoteworkpath/application/ -logfile /tmp/unison.log"
alias zrremotesync="unison -batch -times $zpath ssh://zdevr/$remoteworkpath/application/ -logfile /tmp/unison.log"
# alias zrsync="while : ;do rsync -zPa --exclude=.git/ --exclude=vendor/ $zpath/ ndev://$remoteworkpath/application/; sleep 2; done;"
alias zrsync="rsync -zPa --exclude=.git/ --exclude=vendor/ --exclude=rendered/ --exclude=build/ --delete $zpath/ ndev://$remoteworkpath/application/"
alias zrevsync="rsync -zPa --exclude=.git/ --exclude=vendor/ --exclude=build/ ndev://$remoteworkpath/application/ $zpath/"
alias zsync="zrsync;fswatch --exclude='^flycheck_.*php$' --exclude '.git/' --exclude='^\.#.*' -o $zpath | while read f; do zrsync;done"

alias startnzpoll="unison default $zpath ssh://ndev/$remoteworkpath/application/ -repeat 2 -watch=false  -logfile /tmp/unison.log"
alias startfnpoll="unison default $zpath ssh://ndev/$remoteworkpath/application/ -repeat 2 -watch=false  -prefer $zpath -logfile /tmp/unison.log"

alias icat="kitty +kitten icat"

alias docker=podman
alias docker-compose=podman-compose

# alias k='~/.keyboard.sh'
# alias refreshwifi='sudo dhclient -v -r && sudo dhclient -v wlp3s0'
alias cf='cd $(dirname $(fzf))'
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export GOPATH="$HOME/Development/gocode"
export GOPRIVATE=$(echo "tvguho.pbz/Mbzngb/*"|tr '[A-Za-z]' '[N-ZA-Mn-za-m]')
# export PATH="$PATH:$GOPATH/bin:/home/umar/.yarn/bin"
# export PATH="$PATH:$GOPATH/bin:$HOME/.cargo/bin"
alias lip='ifconfig|grep en0 -A 10| grep '\''inet '\''|awk '\''{print $2}'\'''
alias gip='dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'\''"'\'' '\''{ print $2}'\'''
alias rc='rclone -v --exclude=".git/**"'
alias backup="$HOME/Development/projects/scripts/backup.sh"
# export ANDROID_HOME=$HOME/Development/Android-SDK
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/platform-tools
export EDITOR='emacsclient'
export REACT_EDITOR='emacsclient'
export VISUAL='emacsclient'
export BUP_DIR=/mnt/data/MegaSync/backup
export DISPLAY=":0"

export SCREENRC=~/.config/screen/screenrc

autoload -Uz compinit
compinit
# Completion for kitty kitty + complete setup zsh | source /dev/stdin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh HISTSIZE=10000000
SAVEHIST=10000000

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/umar/Development/projects/Dragger/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/umar/Development/projects/Dragger/node_modules/tabtab/.completions/electron-forge.zsh
