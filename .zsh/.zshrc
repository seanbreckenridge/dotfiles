# Additional alias/function/path manipulation/config

# load functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

alias ll='ls -l'
alias la='ll -a'

