export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export VIRTUALENV_VERSION=15.0.2

if which pyenv > /dev/null;
then
  export PATH=$(pyenv root):$PATH
  eval "$(pyenv init - --no-rehash)"; 
  #eval "$(pyenv virtualenv-init -)"; 
fi
