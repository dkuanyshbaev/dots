# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source $HOME/.cargo/env

eval $(thefuck --alias)

export TERM=xterm-256color
export PS1="\W "

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

alias gotomaya='ssh denis@185.4.64.103'
alias es='sudo docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.6.0'
