# add both my SSH keys to an agent 
# this is so that I can use multiple Github accounts
if [[ ! -S ~/.ssh/ssh_auth_sock ]]; then
	eval "$(ssh-agent)"
	ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l >/dev/null || {
	ssh-add ~/.ssh/id_rsa
	ssh-add ~/.ssh/id_ed25519
}
