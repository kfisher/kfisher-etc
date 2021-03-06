#==============================================================================
# environment.sh
#==============================================================================

#------------------------------------------------------------------------------
# Play Framework
#------------------------------------------------------------------------------
if [ -d "/opt/play-framework/activator-1.2.10" ]; then
  export PATH="$PATH:/opt/play-framework/activator-1.2.10"
fi


#------------------------------------------------------------------------------
# Go
#------------------------------------------------------------------------------
[[ -d "/usr/local/go" ]]         && export PATH="$PATH:/usr/local/go/bin"
[[ -d "$HOME/Projects/go" ]]     && export GOPATH="$HOME/Projects/go"
[[ -d "$HOME/Projects/go/bin" ]] && export PATH="$HOME/Projects/go/bin:$PATH"

#------------------------------------------------------------------------------
# add rbenv/bin to the command path
#------------------------------------------------------------------------------
[[ -d "$HOME/.rbenv/bin" ]] && export PATH="$HOME/.rbenv/bin:$PATH"

[[ -d "$HOME/.local/opt/npm/bin" ]] && export PATH="$HOME/.local/opt/npm/bin:$PATH"
