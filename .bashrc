# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

eval $(thefuck --alias)

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

alias gotomaya='ssh denis@185.4.64.103'
alias es='sudo docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.6.0'
alias api='cd /home/denis/src/go/src/github.com/bitcurate/api'
