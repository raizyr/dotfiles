# Zprezto Setup

```sh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

## Stuff in ~/.zprezto-contrib

* [zsh-z](https://github.com/agkozak/zsh-z.git)

```sh
mkdir -p ~/.zprezto-contrib
git clone git@github.com:agkozak/zsh-z.git ~/.zprezto-contrib/zsh-z
```

* [oh-my-zsh/plugins/aws](https://github.com/ohmyzsh/ohmyzsh.git)

```sh
mkdir -p ~/.zprezto-contrib/oh-my-zsh
pushd ~/.zprezto-contrib/oh-my-zsh
git remote add -f origin git@github.com:ohmyzsh/ohmyzsh.git
echo "plugins/aws" > .git/info/sparse-checkout
git config core.sparseCheckout true
git pull origin master
popd
pushd ~/.zprezto-contrib
ln -s .ohmyzsh/plugins/aws aws
popd
```
