# DIRECTORY
alias l="ls -lh"
alias la="ls -lAh"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias 1="cd -"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="cd -6"
alias 7="cd -7"
alias 8="cd -8"
alias 9="cd -9"

alias md="mkdir -p"
alias rmr="rm -r"
alias rmrf="rm -rf"

# VIM
alias vi=nvim
alias vim=nvim

# GIT
alias g=git
alias ga="git add"
alias gs="git status"
alias gf="git fetch"
alias gp="git push"
alias gl="git pull"
alias gm="git merge"
alias gb="git branch"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gclo="git clone"
alias gr="git rev-parse --show-toplevel"

# GIT: Commits
alias gc="git commit -v"
alias gcm="git commit -m"
alias gca="git commit -v -a"
alias gc!="git commit -v --amend"
alias gca!="git commit -v -a --amend"
alias gcan!="git commit -v -a --amend --no-edit"

# GIT: Log
alias glo="git log --oneline --decorate"
alias glog="git log --oneline --decorate --graph"
alias glol="git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%Creset\""
alias glola="git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%Creset\" --all"

# GIT: Diff
alias gd="git diff"
alias gds="git diff --staged"
alias gdca="git diff --cached"

alias lg="lazygit"

# MISC
alias cl=clear
alias k=kubectl
alias dc=docker-compose

