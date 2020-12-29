# DIRECTORY
abbr l  "ls -lh"
abbr la "ls -lAh"
abbr l1 "ls -1"

abbr ..    "cd .."
abbr ...   "cd ../.."
abbr ....  "cd ../../.."
abbr ..... "cd ../../../.."

abbr md   "mkdir -p"
abbr rmr  "rm -r"
abbr rmrf "rm -rfi"

# VIM
abbr vi  nvim
abbr vim nvim

# GIT
abbr g    git
abbr ga   "git add"
abbr gs   "git status"
abbr gf   "git fetch"
abbr gp   "git push"
abbr gl   "git pull"
abbr gm   "git merge"
abbr gb   "git branch"
abbr gco  "git checkout"
abbr gcob "git checkout -b"
abbr gclo "git clone"
abbr gr   "git rev-parse --show-toplevel"

# GIT: Commits
abbr gc    "git commit -v"
abbr gcm   "git commit -m"
abbr gca   "git commit -v -a"
abbr gc!   "git commit -v --amend"
abbr gca!  "git commit -v -a --amend"
abbr gcan! "git commit -v -a --amend --no-edit"

# GIT: Log
abbr glo   "git log --oneline --decorate"
abbr glog  "git log --oneline --decorate --graph"
abbr glol  "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%Creset\""
abbr glola "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%Creset\" --all"

# GIT: Diff
abbr gd   "git diff"
abbr gds  "git diff --staged"
abbr gdca "git diff --cached"

abbr lg "lazygit"

# MISC
abbr cc clear
abbr k  kubectl
abbr dc docker-compose

# Change config files
abbr cabbrev "$EDITOR ~/.config/fish/conf.d/abbrev.fish"
abbr cfish   "$EDITOR ~/.config/fish/config.fish"
abbr cvi     "$EDITOR ~/.config/nvim"
