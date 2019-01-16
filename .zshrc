# vim: set ts=2 sw=2 sts=2 et ai si :
if [ -f /usr/share/zsh-antigen/antigen.zsh ]; then
	source /usr/share/zsh-antigen/antigen.zsh
elif [ -f /usr/local/share/antigen/antigen.zsh ]; then
	source /usr/local/share/antigen/antigen.zsh
else
	echo "Error: Can not find antigen!"
	exit 1
fi

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
	zsh-users/zsh-syntax-highlighting
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
