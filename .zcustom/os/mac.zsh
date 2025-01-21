# vim:expandtab ts=4 sw=4 syntax=zsh filetype=zsh
# shellcheck disable

zmodule homebrew
zmodule ohmyzsh/ohmyzsh --root plugins/iterm
zmodule $(brew --prefix)/bin/thefuck --cmd 'eval $(thefuck --alias --enable-experimental-instant-mode)'

zmodule ${HOME}/.zcustom \
    --source aws-sso.zsh
