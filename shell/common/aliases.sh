#==============================================================================
# aliases.sh
#==============================================================================

# enable color support by default for ls and grep
#-----------------------------------------------------------------------
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# ls aliases
#-----------------------------------------------------------------------
alias ll='ls -l --almost-all --human-readable'
alias la='ls --almost-all'
alias l='ls -C --classify'

# mkdir
#-----------------------------------------------------------------------
alias mkdir='mkdir --parents'

# quickly go back through parent directories
#-----------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
