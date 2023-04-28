#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# autoload ~/.zfuncs/*
autoload -Uz $HOME/.zfuncs/*(:t)

export GPG_TTY=$(tty)

export GOPATH=$(go env GOPATH)
export GOROOT=$(go env GOROOT)
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export PATH=$PATH:/usr/local/MacGPG2/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

precmd_functions+=(
  set-tab-title-to-repo
)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/chrismcnabb/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

autoload bashcompinit && bashcompinit
complete -C '/opt/homebrew/bin/aws_completer' aws
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"

#
# Pyenv
#
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi

#
# Rbenv
#
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

#
# Aliases
#
alias psql="docker run -it --rm postgres psql"