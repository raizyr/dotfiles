# Let's use Zim | https://zimfw.sh/ | https://github.com/zimfw/zimfw

zstyle ':zim:zmodule' use 'git'

ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi


# autoload ~/.zfuncs/*
# autoload -Uz $HOME/.zfuncs/*(:t)

export GPG_TTY=$(tty)

export PATH=$PATH:/usr/local/MacGPG2/bin:/opt/homebrew/bin:/usr/local/bin:$HOME/bin:$HOME/bin

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# precmd_functions+=(
#   set-tab-title-to-repo
# )

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# export PATH="/Users/chrismcnabb/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# autoload bashcompinit && bashcompinit
# complete -C '/opt/homebrew/bin/aws_completer' aws
# export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"

#
# Pyenv
#
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv >/dev/null 2>&1; then
#   eval "$(pyenv init -)"
#   if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
#     eval "$(pyenv virtualenv-init -)"
#   fi
# fi

#
# Rbenv
#
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init - zsh)"
# fi

#
# Aliases
#
# alias psql="docker run -it --rm postgres psql"
