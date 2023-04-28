#!/usr/bin/env bash

set -o errexit -o pipefail -o noclobber -o nounset

REPO_ROOT=$(git rev-parse --show-toplevel)
INSTALL_LOG=${REPO_ROOT}/.install.log
touch ${INSTALL_LOG}

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

# Fail fast with a concise message when not using bash
# Single brackets are needed here for POSIX compatibility
# shellcheck disable=SC2292
if [ -z "${BASH_VERSION:-}" ]; then
    abort "Bash is required to interpret this script."
fi

# string formatters
tty_mkbold="$(tput bold)"
tty_underline="$(tput smul)"
tty_blue="$(tput setaf 32)"
tty_red="$(tput setaf 196)"
tty_bold="${tty_mkbold} $(tput setaf 255)"
tty_reset="$(tput sgr0)"

shell_join() {
    local arg
    printf "%s" "$1"
    shift
    for arg in "$@"; do
        printf " "
        printf "%s" "${arg// /\ }"
    done
}

chomp() {
    printf "%s" "${1/"$'\n'"/}"
}

ohai() {
    printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

morehai() {
    printf "${tty_blue}==>${tty_bold} %s${tty_reset}" "$(shell_join "$@")"
}

donehai() {
    printf "${tty_blue}==>${tty_bold} %s${tty_reset}" "$(shell_join "$@")"
}

warn() {
    printf "${tty_red}Warning${tty_reset}: %s\n" "$(chomp "$1")" >&2
}

morehai "Looking for homebrew..."
if command -v brew >/dev/null 2>&1; then
    echo "already installed."
else
    echo "not found."
    echo -n "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >>${INSTALL_LOG} 2>&1
    echo "done."
fi
