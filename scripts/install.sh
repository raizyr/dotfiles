#!/usr/bin/env bash
# vim :set ts=4 sw=4 sts=4 et 

set -o errexit -o pipefail -o noclobber -o nounset

REPO_ROOT=$(git rev-parse --show-toplevel)
INSTALL_LOG=${HOME}/.dotfiles.install.log
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
tty_orange="$(tput setaf 208)"
tty_green="$(tput setaf 76)"
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

yesno() {
    read -p "$1 (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    fi
}

ohai() {
    printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

checkhai() {
    printf "${tty_orange}==>${tty_bold} %s ${tty_reset}" "$(shell_join "$@")"
}

okhai() {
    printf "${tty_green}✔️${tty_bold} %s\n${tty_reset}" "$(shell_join "$@")"
}

nohai() {
    printf "${tty_red}‼️${tty_bold} %s\n${tty_reset}" "$(shell_join "$@")"
}

donehai() {
    printf "${tty_green}==>${tty_bold} %s\n${tty_reset}" "$(shell_join "$@")"
}

warn() {
    printf "${tty_red}Warning${tty_reset}: %s\n" "$(chomp "$1")" >&2
}

_check_file() {
    local file=$1
    if [ -f "${file}" ]; then
        echo "found."
        checkhai "Comparing ${file} with ${REPO_ROOT}/${file}..."
        if [ "$(cat ${file})" = "$(cat ${REPO_ROOT}/${file})" ]; then
            donehai "${file} already installed."
        else
            nohai "."
            warn "${file} is different from ${REPO_ROOT}/${file}."
            # prompt the user to fix the file
            if yesno "Do you want to backup and fix the file?"; then
                mv ${file} ${file}.backup
                cp ${REPO_ROOT}/${file} ${file}
            fi
        fi
    fi
}

_check_symlink() {
    local file=$1
    local link=$2
    if [ -e "${link}" ] && [ ! -L "${link}" ]; then
        echo "found."
        warn "${link} is a file, but it should be a symlink to ${REPO_ROOT}/${file}."
        if yesno "Do you want to backup the file and fix the symlink?"; then
            mv ${link} ${link}.backup
            ln -s ${REPO_ROOT}/${file} ${link}
            donehai "${link} fixed."
        else abort
        fi
    elif [ -L "${link}" ]; then
        echo "found."
        checkhai "Comparing ${link} with ${REPO_ROOT}/${file}..."
        # check if the symlink is correct
        if [ "$(readlink ${link})" = "${REPO_ROOT}/${file}" ]; then
            okhai "${link} already installed."
        else
            
            warn "${link} is a symlink to $(readlink ${link}), but it should be a symlink to ${REPO_ROOT}/${file}."
            # prompt the user to fix the symlink
            if yesno "Do you want to fix the symlink?"; then
                rm ${link}
                ln -s ${REPO_ROOT}/${file} ${link}
                donehai "${link} fixed."
            fi
        fi
    else
        echo "not found."
        ohai "Installing ${link}..."
        ln -s ${REPO_ROOT}/${file} ${link}
        donehai "${link} installed."
    fi
}

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
  ON_LINUX=1
elif [[ "${OS}" == "Darwin" ]]
then
  ON_MACOS=1
else
  abort "dotfiles installation is only supported on macOS and Linux."
fi

__brew() {
    checkhai "Looking for homebrew..."
    if command -v brew >/dev/null 2>&1; then
        echo "found."
        donehai "Homebrew already installed."
    else
        echo "not found."
        ohai "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >>${INSTALL_LOG} 2>&1
        donehai "Homebrew installed."
    fi
}

__brew_packages() {
    if command -v brew >/dev/null 2>&1; then
        ohai "Installing brew packages..."
        brew bundle --file=${REPO_ROOT}/Brewfile | tee -a ${INSTALL_LOG}
        donehai "Brew packages installed."
    else
        warn "Homebrew not installed. Skipping brew packages."
    fi
}

__vim() {
    checkhai "Checking vim configuration..."
    if [ -d ~/.vim ]; then
        echo "already installed."
    else
        echo "not found."
        ohai "Installing vim configuration..."
        
        ohai "Creating vim directory layout..."
        mkdir -p ~/.vim/autoload
        mkdir -p ~/.vim/tmp/{swaps,backups,undos}
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        _check_symlink vimrc ~/.vimrc
        donehai "Vim configuration installed"

        ohai "Installing vim plugins..."
        vim +PlugInstall +qall
        donehai "Vim plugins installed"
    fi
}

__zshell() {
    checkhai "Checking .zshrc..."
    _check_symlink zshrc ~/.zshrc
    donehai ".zshrc installed"

    checkhai "Checking .zshenv..."
    _check_symlink zshenv ~/.zshenv
    donehai ".zshenv installed"

    checkhai "Checking .zcustom..."
    _check_symlink zcustom ~/.zcustom
    donehai ".zcustom installed"

    checkhai "Checking .zfuncs..."
    _check_symlink zfuncs ~/.zfuncs
    donehai ".zfuncs installed"
    
    checkhai "Checking zimfw..."
    if [ -d ~/.zim ]; then
        echo "already installed."
    else
        echo "not found."
        ohai "Installing zimfw..."
        curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
        donehai "zimfw installed"
    fi

    checkhai "Checking .zimrc..."
    _check_symlink zimrc ~/.zimrc
    donehai ".zimrc installed"
}

__dirs() {
    ohai "Creating directory layout..."
    mkdir -p ~/{src,bin,pkg,tmp}
    donehai "Directory layout created"
}

__dotfiles() {
    ohai "Checking out dotfiles repository..."
    if [ -d ~/.dotfiles ]; then
        echo "already installed."
    else
        echo "not found."
        ohai "Installing dotfiles repository..."
        git clone https://github.com/dotfiles/dotfiles.git ~/.dotfiles
        donehai "Dotfiles repository installed"
    fi
}

__main() {
    __dotfiles
    __dirs
    __vim
    __zshell
    __brew
    __brew_packages
}


# Invalidate sudo timestamp before exiting (if it wasn't active before).
if [[ -x /usr/bin/sudo ]] && ! /usr/bin/sudo -n -v 2>/dev/null
then
  trap '/usr/bin/sudo -k' EXIT
fi

__main
