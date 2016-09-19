# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="wezm"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew brew-cask github gitignore history sublime tmux)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=ja_JP.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#####################################################################

# My configuration

# Command Line ToolsをPATHに追加
export PATH=$PATH:/Applications/Xcode.app/Contents//Developer/usr/bin

# aliases
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpod='git push origin develop'
alias gcm='git commit -m'
alias less='less -R'
alias db='cd ~/Dropbox'
alias do='cd ~/Downloads'
alias de='cd ~/Desktop'
alias wo='cd ~/work'
alias t='cd ~/tmp'
alias o='open'
alias grepi='grep -i'
if [[ -x `which tree` ]]; then
    alias tree='tree -N'
fi
if [[ -x `which ack` ]]; then
    alias ackl='ack --pager=less'
    alias acki='ack -i'
    alias ackli='ack --pager=less -i'
fi
if [[ -x `which colordiff` ]]; then
    alias diff='colordiff -u'
else
    alias diff=`diff -u`
fi
if [[ -x `which rmtrash` ]]; then
    alias alias rm='rmtrash'
else
    alias diff=`rm -i`
fi
if [[ -x `which autojump` && -f '/usr/local/bin/jo' ]]; then
    alias jos='/usr/local/bin/jo'
fi

# vimキーバインドにする
bindkey -v

# rbenvの初期設定
eval "$(rbenv init -)"

# Ctrl + r でpecoと連携したhistory検索
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# autojumpの設定
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# GNU Source-highlightを使用してlessでソースコードに色を付ける
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# GO言語のパス設定
export GOPATH=$HOME/.go
if [[ ! -d $GOPATH ]]; then
    mkdir $GOPATH
fi
export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

# direnvの設定
export EDITOR=vim
eval "$(direnv hook zsh)"
