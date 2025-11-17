# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
ts-nodemon(){ nodemon --exec "ts-node $1" --ext "ts"; }
babel-nodemon(){ nodemon --exec "babel-node $1" --ext "js"; }
py-nodemon(){ nodemon --exec "python3 $1" --ext "py"; }

alias vpn="cd /home/agilelpt74/vpn && ./startVPN.sh"
alias pull="git pull"
alias fetch="git fetch --all"
alias stash="git stash"
alias pop="git stash pop"
alias work="cd /home/agilelpt74/Documents/work/agile"
alias checkout="git checkout $1"
alias nestalt="node_modules/.bin/nest $1 $2 $3"
alias stop="sudo service $1 stop"
alias start="sudo service $1 start"
alias status="echo 'test' $1 'is working'"
alias startpsql="psql -h localhost -p 5432 -U postgres"
alias startpsqliviraanalytics="psql -h 192.168.2.32 -p 14 -U postgres"
alias startpsql202="psql -h 192.168.4.10 -p 14 -U ivira_node"

alias startMongod="sudo service mongod start"
alias stopMongod="sudo service mongod stop"
alias startRedis="sudo service redis-server start"
alias stopRedis="sudo service redis-server stop"
alias startPostgresql="sudo service postgresql start"
alias stopPostgresql="sudo service postgresql stop"
alias startMysql="sudo service mysql start"
alias stopMysql="sudo service mysql stop"
alias startNginx="sudo service nginx start"
alias stopNginx="sudo service nginx stop"
alias commitRebuild="runLint && npm run build && git add -A && git commit -m 'rebuild'"
alias devServer="npm run start:dev"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
. "/home/agilelpt74/.deno/env"

alias runLint="npm run lint && npm run prettier"
alias pgDump="pg_dump -U $3 -h $1 -p $2 -F c -f $5 $4"
alias pgRestore="pg_restore -h $1 -p $2 -U $3 -d $4 -v $5"
alias codex="cd $1"

# export PATH="/opt/sonar-scanner/bin:$PATH" source /home/agilelpt74/.bashrc
# export PATH="/opt/sonar-scanner/bin:$PATH" source /home/agilelpt74/.bashrc
alias prepareStaging="git branch -D staging review_staging && git checkout staging && git pull && git checkout review_staging && git pull && git merge staging"
alias prepareProduction="git branch -D production review_production && git checkout production && git pull && git checkout review_production && git pull && git merge production"
alias prepareDevelop="rm -rf dist && git branch -D master review_development && git checkout master && git pull && git checkout review_development && git pull && git merge master"
alias iviraA="work && code ivira/a/user-svc-a && exit"
alias iviraB="work && code ivira/b/user-svc-b && exit"
alias iviraC="work && code ivira/c/user-svc-c && exit"
alias updateSystem="sudo apt update -y && sudo apt upgrade -y"