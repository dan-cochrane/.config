CONFIG_DIR=$(dirname $(realpath ${(%):-%x}))
DOT_DIR=$CONFIG_DIR/../

source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

source $CONFIG_DIR/aliases.sh
source $CONFIG_DIR/p10k.zsh
source $CONFIG_DIR/extras.sh

