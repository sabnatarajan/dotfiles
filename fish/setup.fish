#Fish
abbr setl "set -l"

abbr y fish_clipboard_copy
abbr p fish_clipboard_paste

# DIRECTORY
abbr -a -- - 'cd -'
abbr l   "exa --long --header"
abbr la  "exa --long --header --all"
abbr lag "exa --long --header --all --grid"
abbr l1  "exa -1"
abbr lt  "exa --tree"
abbr llt "exa --long --tree"

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

# MISC
abbr cat  bat
abbr catp bat -p
abbr cc   clear
abbr dc   docker-compose
abbr lg   lazygit

# Change config files
abbr cdot     "$EDITOR ~/git/dotfiles"
abbr dotfiles "cd ~/git/dotfiles"
abbr cabbrev  "$EDITOR ~/.config/fish/conf.d/abbrev.fish"
abbr cfish    "$EDITOR ~/.config/fish/config.fish"
abbr cvi      "$EDITOR ~/.config/nvim/init.lua"

# Git
abbr g    git
abbr ga   "git add"
abbr gap  "git add --patch"
abbr gs   "git status"
abbr gf   "git fetch"
abbr gp   "git push"
abbr gpu  "git push -u"
abbr gpa  "git push --all"
abbr gll  "git pull"
abbr gm   "git merge"
abbr gb   "git branch"
abbr gbf  "git branch | fzf"
abbr gba  "git branch -a"
abbr gbaf "git branch -a | fzf"
abbr gco  "git checkout"
abbr gcob "git checkout -b"
abbr gclo "git clone"
abbr gr   "git rev-parse --show-toplevel"
abbr gre  "git restore"
abbr grs  "git reset"
abbr gw   "git worktree"
abbr gwl  "git worktree list"
abbr gwa  "git worktree add"
abbr gwab "git worktree add -b"
abbr gwm  "git worktree move"

# Commits
abbr gc    "git commit -v"
abbr gcm   "git commit -m"
abbr gca   "git commit -v -a"
abbr gcam  "git commit -v -a -m"
abbr gcx   "git commit -v --amend"
abbr gcxa  "git commit -v -a --amend"
abbr gcxn  "git commit -v --amend --no-edit"

# Log
abbr gl    "git log"
abbr gls   "git log --show-signature"
abbr glo   "git log --oneline --decorate"
abbr glog  "git log --oneline --decorate --graph"
abbr glol  "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%Creset\""
abbr glols "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%C(cyan) <Sign: %G?>%Creset\""
abbr glola "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s%Cgreen (%cr) %C(bold blue)<%an>%Creset\" --all"


# Diff
abbr gd   "git diff"
abbr gds  "git diff --staged"
abbr gdc  "git diff --cached"

# Stash
abbr gst  "git stash"
abbr gstl "git stash list"
abbr gstp "git stash pop"

# Kubernetes
abbr k    kubectl
abbr kx   kubectx
abbr ka   kubectl apply

abbr kg   kubectl get
abbr kga  kubectl get all
abbr kgaa kubectl get all -A
abbr kgp  kubectl get po
abbr kgd  kubectl get deploy
abbr kgs  kubectl get svc
abbr kgi  kubectl get ing
abbr kgn  kubectl get ns

abbr ke   kubectl edit
abbr kep  kubectl edit po
abbr ked  kubectl edit deploy
abbr kes  kubectl edit svc
abbr kei  kubectl edit ing
abbr ken  kubectl edit ns

abbr kd   kubectl delete
abbr kdp  kubectl delete po
abbr kdd  kubectl delete deploy
abbr kds  kubectl delete svc
abbr kdi  kubectl delete ing
abbr kdn  kubectl delete ns

# Herbstluftwm
abbr hc herbstclient

# Nix
abbr n   nix
abbr ne  nix-env
abbr nei nix-env -iA 
abbr neq nix-env -q
abbr ngc nix-collect-garbage
abbr nb  nix-build
abbr nsh nix-shell
abbr ns  nix-store
abbr nh  nix-hash
abbr nch nix-channel
abbr nd  nix-daemon

