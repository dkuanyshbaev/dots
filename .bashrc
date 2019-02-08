# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM=xterm-256color
export PS1="\W "

# export RUST_SRC_PATH=~/.rust/src
# export PATH=$PATH:/home/denis/.cargo/bin
# export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/
# export PATH=$PATH:/home/denis/.cargo/bin

source $HOME/.cargo/env

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

export EDITOR=vim
export NNN_USE_EDITOR=1

alias count='ls | wc -l'
alias gotomaya='ssh denis@185.4.64.103'
alias gotobit='ssh bitcurate@138.68.225.174'
