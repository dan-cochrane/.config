#!/bin/bash

cd ~
sudo apt-get remove --auto-remove neovim && echo "Removed Neovim..."
curl -LO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage nvim
sudo mv nvim /usr/local/bin

echo "Installed neovim v0.7.0..."

