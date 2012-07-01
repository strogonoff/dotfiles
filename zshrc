# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# export TERM='ansi'
export TERM='xterm-256color'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sunrise"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git mercurial osx brew compleat github pip python)
plugins=(git mercurial osx brew compleat github pip python)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# VIRTUALENV
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PROJECT_HOME=$HOME/Development
export WORKON_HOME=$HOME/Development/.pyenvs
export CLICOLOR=1;

source /usr/local/bin/virtualenvwrapper.sh

killit() {
    # Kills any process that matches a regexp passed to it
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs kill
}

alias updick='/usr/bin/uptime | perl -ne "/(\d+) d/;print 8,q(=)x\$1,\"D\n\""'
alias bitch,='/usr/bin/sudo'

export PATH=$PATH:/Users/anton/Applications/Poedit.app/Contents/MacOS

# Git shortcuts https://github.com/ndbroadbent/scm_breeze
#[ -s "/Users/anton/.scm_breeze/scm_breeze.sh" ] && source "/Users/anton/.scm_breeze/scm_breeze.sh"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

export LANG="en_US.UTF-8"
#export LC_COLLATE="en_US.UTF-8"
#export LC_CTYPE="en_US.UTF-8"
#export LC_MESSAGES="en_US.UTF-8"
#export LC_MONETARY="en_US.UTF-8"
#export LC_NUMERIC="en_US.UTF-8"
#export LC_TIME="en_US.UTF-8"
#export LC_ALL="en_US.UTF-8"
