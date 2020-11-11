
# colors
set colored-stats on

export SHELL="/bin/bash"
export EDITOR="/usr/bin/nvim"

# Nice output and secure deletion/moving and verbosity
if [ "$TERM" != "dumb" ]; then
 eval "`dircolors -b`"
 alias ll='ls -l -F -h -X --group-directories-first --color=always --hide=*~'
 alias lla='ls -lA -F -h -X --group-directories-first --color=always'
fi

alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias rm='rm -iv'
alias cp='cp -vR'

# Handy directory aliases
# alias ..='cd ..'
# alias ...='..;..'
# alias ....='..;...'
# alias .....='..;....'

# Handy directory aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

LANG=en_GB.UTF-8
LANGUAGE=en_US
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
