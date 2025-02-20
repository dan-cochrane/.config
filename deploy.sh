#!/bin/bash
set -euo pipefail
USAGE=$(cat <<-END
    Usage: ./deploy.sh [OPTIONS], eg. ./deploy.sh --local
    Creates ~/.zshrc and ~/.tmux.conf with location
    specific config

    OPTIONS:
        --local                 deploy local config only, only common aliases are sourced
END
)

export DOT_DIR=$(dirname $(realpath $0))

LOC="remote"
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
        --local)
            LOC="local" && shift ;;
        --) # end argument parsing
            shift && break ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2 && exit 1 ;;
    esac
done


echo "deploying on $LOC machine..."

# tmux setup
echo "source $DOT_DIR/config/tmux.conf" > $HOME/.tmux.conf

# zshrc setup
echo "source $DOT_DIR/config/zshrc.sh" > $HOME/.zshrc

# add remote specific aliases for vm
if [ $LOC = 'remote' ]; then
    echo "source $DOT_DIR/config/aliases_speechmatics.sh" >> $HOME/.zshrc
fi

# nvm setup
# something wrong, need NVM_DIR here
export NVM_DIR="$HOME/.nvm"
NVM_SETUP=$(cat <<-END
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
END
)
echo "$NVM_SETUP" >> $HOME/.zshrc

zsh
