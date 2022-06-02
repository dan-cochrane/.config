CONFIG_DIR=$(dirname $(realpath ${(%):-%x}))
DOT_DIR=$CONFIG_DIR/../

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH=$HOME/.zsh

plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search)

source $CONFIG_DIR/aliases.sh
# source $CONFIG_DIR/p10k.zsh
source $CONFIG_DIR/extras.sh
