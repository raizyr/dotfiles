# vim:expandtab ts=4 sw=4 syntax=zsh filetype=zsh
# shellcheck disable

# What OS are we running?
if [[ $(uname) == "Darwin" ]]; then
    source "$ZSH_CUSTOM"/os/mac.zsh

elif command -v freebsd-version > /dev/null; then
    source "$ZSH_CUSTOM"/os/freebsd.zsh

elif command -v apt > /dev/null; then
    source "$ZSH_CUSTOM"/os/debian.zsh

else
    echo 'Unknown OS!'
fi

# Do we have systemd on board?
if command -v systemctl > /dev/null; then
    source "$ZSH_CUSTOM"/os/systemd.zsh
fi

# Ditto Kubernetes?
if command -v kubectl > /dev/null; then
    source "$ZSH_CUSTOM"/os/kubernetes.zsh
fi
