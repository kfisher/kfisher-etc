#==============================================================================
# bashrc.sh
#==============================================================================

# don't do anything if not running interactively.
#------------------------------------------------------------------------------
[[ $- != *i* ]] && return

# command history settings
#------------------------------------------------------------------------------
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# shell prompt
#------------------------------------------------------------------------------
export PS1="[ \u@\h ][ \w ]\n:/ "

# aliases
#------------------------------------------------------------------------------
source "$HOME/.local/etc/shell/common/aliases.sh"

# enable completion
#------------------------------------------------------------------------------
if [ -r /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

# load environmental settings
#------------------------------------------------------------------------------
source "$HOME/.local/etc/shell/common/environment.sh"

# initialize rbenv
#------------------------------------------------------------------------------
[[ -d "$HOME/.rbenv" ]] && eval "$(rbenv init -)"
