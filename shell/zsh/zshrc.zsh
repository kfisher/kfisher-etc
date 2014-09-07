#==============================================================================
# zshrc.zsh
#==============================================================================

# Options
#------------------------------------------------------------------------------
setopt appendhistory autocd extendedglob nomatch
unsetopt beep

# Key Bindings
#------------------------------------------------------------------------------
bindkey -e

# Command History Settings
#------------------------------------------------------------------------------
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Completions
#------------------------------------------------------------------------------
autoload -Uz compinit
compinit
setopt completealiases

# Shell Prompt
#------------------------------------------------------------------------------
export PS1="$ZSHENV_LOADED$:/ "

# Aliases
#------------------------------------------------------------------------------
source "$HOME/.local/etc/shell/common/aliases.sh"

# Load environmental settings. This can't be done in zshenv because archlinux
# sources /etc/profile after ~/.zshenv overriding any command path changes.
#------------------------------------------------------------------------------
source "$HOME/.local/etc/shell/common/environment.sh"

# Initialize rbenv.
#------------------------------------------------------------------------------
[[ -d "$HOME/.rbenv" ]] && eval "$(rbenv init -)"
