if command -v pyenv >/dev/null 2>&1; then
  export PATH=$(pyenv root):$PATH
  eval "$(pyenv init - --no-rehash)"
  #eval "$(pyenv virtualenv-init -)";
fi
