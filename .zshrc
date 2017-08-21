source ~/src/github.com/zsh-users/antigen/antigen.zsh

antigen bundles <<EOBUNDLES
	git
	command-not-found
	nojhan/liquidprompt
	osx
	golang
	vundle
	thefuck
	scd
	Tarrasch/zsh-autoenv
EOBUNDLES

antigen use oh-my-zsh

antigen apply

# load custom files
for config_file ($HOME/.zcustom/*.zsh(N)); do
	source $config_file
done

# autoload ~/.zfuncs/*
autoload -Uz $HOME/.zfuncs/*(:t)
unset config_file
