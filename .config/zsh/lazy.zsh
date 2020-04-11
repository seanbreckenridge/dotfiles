#!/usr/bin/env zsh

# lazy load shell tools that otherwise
# cause a bunch of lag on start up

fuck() {
	eval $(thefuck --alias) # redefines the function
	fuck "$@"
}
