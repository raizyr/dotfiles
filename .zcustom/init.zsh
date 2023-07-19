# shellcheck disable
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

# Initialize modules.
source ${ZIM_HOME}/init.zsh

fpath=(
  ~/.zfuncs
  ~/.zfuncs/**/*~*/(CVS)#(/N)
  "${fpath[@]}"
)
autoload -Uz $HOME/.zfuncs/*(:t)

export GPG_TTY=$(tty)

export PATH=$PATH:/usr/local/MacGPG2/bin:/opt/homebrew/bin:/usr/local/bin:$HOME/bin:$HOME/bin

### Put other stuff here ###
export SHOW_AWS_PROMPT=false

# eval $(thefuck --alias --enable-experimental-instant-mode)
# eval $(thefuck --alias)
