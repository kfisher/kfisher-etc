#==============================================================================
# zshrc.zsh
#==============================================================================

# options
#------------------------------------------------------------------------------
setopt appendhistory autocd extendedglob nomatch
unsetopt beep

# key bindings
#------------------------------------------------------------------------------
bindkey -e

# command history settings
#------------------------------------------------------------------------------
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# completions
#------------------------------------------------------------------------------
autoload -Uz compinit
compinit
setopt completealiases

# shell prompt
#------------------------------------------------------------------------------
export PS1="$:/ "

# aliases
#------------------------------------------------------------------------------
source "$HOME/.local/etc/shell/common/aliases.sh"

# initialize rbenv
#------------------------------------------------------------------------------
[[ -d "$HOME/.rbenv" ]] && eval "$(rbenv init -)"
