# If not running interactively, don't do anything
case $- in *i*) ;; *) return;; esac
# bash completion
if [[ -f /etc/bash_completion ]]; then
	/etc/bash_completion
fi
# history stuff
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=500
HISTFILESIZE=1000
HISTFILE=~/.local/history
# update the values of LINES and COLUMNS on window resize
shopt -s checkwinsize
# prompt
PS1='\033[1;31m\W/ \e[0m'
# PROMPT_COMMAND='echo -en "\033]0;[${PWD##*/}]\a"'
PROMPT_COMMAND='echo -en "\033]0;$(pwd)\a"'
# Path
export PATH=~/.local/bin:$PATH
export PATH=~/.config/scripts:$PATH 
# editor
export EDITOR="nvim"
# shorten long commands
alias ga='git add .'
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias g="cd ~/git"
alias autoremove='yay -Rsn $(yay -Qdtq)'
alias mpv="mpv --loop=inf"
alias img="\mpv --loop=inf --pause"
alias dio="gio tree"
alias rickroll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
# options for commands
alias ls="ls -A --color=yes --group-directories-first"
alias rm="rm -Ir"
# shorten name
alias v="nvim"
alias py="python"
alias open="xdg-open"
# other
shopt -s autocd
