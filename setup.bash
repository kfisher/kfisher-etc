#!/usr/bin/env bash
#==============================================================================
# setup.bash - install configuration files.
#==============================================================================

ORIGPATH="$HOME/.orig"
OPTIONS="bash zsh"
TIMESTAMP="$(date +"%Y-%m-%d_%H%M")"

#---- FUNCTION ----------------------------------------------------------------
#        NAME: usage
# DESCRIPTION: Display usage information for this script.
#------------------------------------------------------------------------------
usage() {
  echo "usage: setup.bash [bash] [zsh]"
  echo "If no option is specified, all configurations will be installed."
}

#---- FUNCTION ----------------------------------------------------------------
#        NAME: is_valid
# DESCRIPTION: Determines if an argument is valid. If an argument is not valid,
#              the script exits with a non-zero exit status.
# PARAMETER 1: Argument being checked.
#------------------------------------------------------------------------------
is_valid() {
  for option in $OPTIONS; do
    [[ "$1" = "$option" ]] && return 0
  done
  usage
  exit 1
}

#---- FUNCTION ----------------------------------------------------------------
#        NAME: backup_file
# DESCRIPTION: Moves the given file into the backup directory unless the given
#              path is a symbolic link. In this case, the link is removed.
# PARAMETER 1: Source path.
# PARAMETER 2: Destination path.
#------------------------------------------------------------------------------
backup_file() {
  if [ -e "$1" ]; then
    if [ -L "$1" ]; then
      rm $1
    else
      mv $1 $2
    fi
  fi
}

#---- FUNCTION ----------------------------------------------------------------
#        NAME: setup_bash
# DESCRIPTION: Install the bourne-again shell (bash) configuration files.
#------------------------------------------------------------------------------
setup_bash() {
  echo "installing bash files"

  echo -n "  .. backing up original files              "
  backup_file "$HOME/.bashrc" "$ORIGPATH/bashrc_$TIMESTAMP.sh"
  backup_file "$HOME/.bash_profile" "$ORIGPATH/bash_profile_$TIMESTAMP.sh"
  backup_file "$HOME/.profile" "$ORIGPATH/profile_$TIMESTAMP.sh"
  echo "   [success]"

  echo -n "  .. installing configuration files         "
  ln -s "$HOME/.local/etc/shell/bash/bashrc.sh" "$HOME/.bashrc"
  ln -s "$HOME/.local/etc/shell/bash/bash_profile.sh" "$HOME/.bash_profile"
  echo "   [success]"
}

#---- FUNCTION ----------------------------------------------------------------
#        NAME: setup_zsh
# DESCRIPTION: Install the z shell (zsh) configuration files.
#------------------------------------------------------------------------------
setup_zsh() {
  echo "installing zsh files"

  echo -n "  .. backing up original files              "
  backup_file "$HOME/.zshrc" "$ORIGPATH/zshrc_$TIMESTAMP.sh"
  backup_file "$HOME/.zshenv" "$ORIGPATH/zshenv_$TIMESTAMP.sh"
  echo "   [success]"

  echo -n "  .. installing configuration files         "
  ln -s "$HOME/.local/etc/shell/zsh/zshrc.zsh" "$HOME/.zshrc"
  ln -s "$HOME/.local/etc/shell/zsh/zshenv.zsh" "$HOME/.zshenv"
  echo "   [success]"
}

#---- FUNCTION ----------------------------------------------------------------
#        NAME: main
# DESCRIPTION: Runs the script.
#------------------------------------------------------------------------------
main() {
  if [ $# -eq 0 ]; then
    configs=$OPTIONS
  else
    for option in $*; do is_valid "$option"; done
    configs=$*
  fi

  mkdir -p "$ORIGPATH"

  for config in $configs; do
    case "$config" in
      "bash")
        setup_bash
        ;;
      "zsh")
        setup_zsh
        ;;
    esac
  done

  exit 0
}

main $@
