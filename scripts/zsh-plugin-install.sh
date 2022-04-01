#!/bin/bash

# install p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k && "Installed p10k"

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions && echo "Cloned autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting && echo "Cloned syntax highlighting"

# clone the .config repo
[ -d ~/.config ] && mv ~/.config ~/.config_old
git clone git@github.com:dpc46/.config.git

# install the latest stable nvim release and add to path
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
sudo ln -s ~/nvim.appimage /usr/bin/nvim