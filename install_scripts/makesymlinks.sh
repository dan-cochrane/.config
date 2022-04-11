#!/bin/bash

dir=~/.config
files="zshrc p10k.zsh tmux.conf"

[ -d "$dir" ] || echo "No .config dir found"

for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done
