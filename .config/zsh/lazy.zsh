# lazy load shell tools that otherwise
# cause a bunch of lag on start up

fuck() {
	eval $(thefuck --alias) # redefines the function
	fuck "$@"
}

nvm() {
	NPM_CONFIG_PREFIX= source_if_exists /usr/share/nvm/init-nvm.sh && alias nvm='NPM_CONFIG_PREFIX= nvm'
	nvm "$@"
}
