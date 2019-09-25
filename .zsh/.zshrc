# Additional alias/function/config

# load functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

# Aliases
alias ll='ls -l'
alias la='ll -a'
