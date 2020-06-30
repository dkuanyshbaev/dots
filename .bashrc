# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export PS1="\W "
# export TERM=xterm-256color

alias mouseup='sudo modprobe -r psmouse && sudo modprobe psmouse'
alias gotokinder='ssh denis@kinderdom.org -p 23000'
alias gotosulaco='ssh denis@192.168.1.44 -p 4444'
alias gotozee1='ssh denis@n-force.nl -p 4444'
alias gotozee2='ssh denis@108.61.166.170 -p 4444'
alias gotostreams='ssh denis@104.248.250.36'

# for rpi builds
# export PATH="/opt/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf/bin:$PATH"


