# first dotfile to be loaded - define zsh environment variables

# rest of zsh dotfile configuration
export ZDOTDIR="${HOME}/.config/zsh"

# locations for additional functons
export fpath=( "${ZDOTDIR}/functions" ${fpath[@]} )

### HISTORY SETTINGS ###

HISTFILE="${ZDOTDIR}/zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory

# History Control: Omit duplicate and commands that begin with a space
export HISTCONTROL='ignoreboth';

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applicaitons

export EDITOR='nvim'
export PAGER='less'
export TERMINAL='termite'
export BROWSER='firefox-developer-edition'
export READER='okular'

