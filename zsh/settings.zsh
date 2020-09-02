zstyle ':completion:*' menu select
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

setopt autocd               # Automatically change to directory

# History
HISTSIZE=1048576
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zsh_history
SAVEHIST=$HISTSIZE
setopt append_history       # Append to the history file
setopt hist_ignore_all_dups # No duplicates in the history file
setopt inc_append_history   # Write to history file immediately
setopt extended_history     # Show timestamp in history
setopt share_history        # Share history between all sessions
setopt hist_expire_dups_first # Expire duplicate history entry first
setopt hist_ignore_space # Don't record to history if starting with space

# Completion
# setopt complete_in_word         # Complete from both ends of a word.
# setopt always_to_end            # Move cursor to the end of a completed Word.
# setopt path_dirs                # Perform path search even on command names with slashes.
# setopt auto_menu                # Show completion menu on a successive tab press.
# setopt auto_list                # Automatically list choices on ambiguous completion.
# setopt auto_param_slash         # If completed parameter is a directory, add a trailing slash.
