# mac-specific shell startup commands

# check if supervisord (background processes are running)
# else start them
#
# this does mean processes don't start running till
# I open a terminal, but I start one on boot anyways

if [[ ! -e /tmp/supervisord.pid ]]; then
	echo "Supervisor pid file does not exist, starting supervisor..."
	super --daemon
fi
