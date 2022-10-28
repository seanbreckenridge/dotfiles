#!/bin/zsh

housekeeping-info() {
	housekeeping
	housekeeping
	EVRY_JSON=1 housekeeping | describe-evry-json
}

alias hi='housekeeping-info'
# nsxiv full screen image, fit full width
alias nsxfull='nsxiv -s f -f'

# power
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias halt='sudo systemctl halt'
alias shutdown='poweroff'

# Non-standard
alias syserrors='sudo journalctl -p 3 -xb'
alias sysderrors='sudo systemctl --failed'
# remove packages that arent being used for anything
alias list-orphans='pacman -Qtdq'
alias remove-orphans='sudo pacman -Rns $(list-orphans)'
# clear yay tar.gz cache
alias yay-clear-cache='yay -Syu && yay -Sc'
alias rnm='sudo systemctl restart NetworkManager' # restart networkmanager
