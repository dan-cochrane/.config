#!/bin/bash
set -euo pipefail
USAGE=$(cat <<-END
    Usage: ./install.sh [OPTION]
    Install dotfile dependencies on mac or linux

    OPTIONS:
        --tmux       install tmux
        --zsh        install zsh 
        --nvm        install nvm 

    If OPTIONS are passed they will be installed
    with apt if on linux or brew if on OSX
END
)

zsh=false
tmux=false
nvm=false
force=false
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
        --zsh)
            zsh=true && shift ;;
        --tmux)
            tmux=true && shift ;;
        --nvm)
            nvm=true && shift ;;
        --force)
            force=true && shift ;;
        --) # end argument parsing
            shift && break ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2 && exit 1 ;;
    esac
done

operating_system="$(uname -s)"
case "${operating_system}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${operating_system}"
esac

# Installing on linux with apt
if [ $machine == "Linux" ]; then
    [ $zsh == true ] && sudo apt-get install -y zsh
    [ $tmux == true ] && sudo apt-get install -y tmux 

# Installing on mac with homebrew
elif [ $machine == "Mac" ]; then
    brew install coreutils  # Mac won't have realpath before coreutils installed
    [ $zsh == true ] && brew install zsh
    [ $tmux == true ] && brew install tmux
fi

# install nvm
NVM=~/.nvm
if [ -d $NVM ] && [ "$force" == "false" ]; then
    echo "Skipping download of nvm, pass --force to force the download"
else
    git clone https://github.com/nvm-sh/nvm.git ~/.nvm && cd ~/.nvm && git checkout v0.39.1
fi


# install zsh plugins
ZSH=~/.zsh
if [ -d $ZSH ] && [ "$force" = "false" ]; then
    echo "Skipping download of zsh plugins, pass --force to force redeownload"
else
    echo " --------- INSTALLING DEPENDENCIES ⏳ ----------- "
    rm -rf $ZSH && mkdir $ZSH

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH:-~/.zsh}/powerlevel10k 

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH:-~/.zsh}/zsh-syntax-highlighting 

    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH:-~/.zsh}/zsh-autosuggestions 

    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH:-~/.zsh}/zsh-completions 

    git clone https://github.com/zsh-users/zsh-history-substring-search \
        ${ZSH:-~/.zsh}/zsh-history-substring-search 
    
    echo " --------- INSTALLED SUCCESSFULLY ✅ ----------- "
    echo " --------- NOW RUN ./deploy.sh [OPTION] -------- "
fi

