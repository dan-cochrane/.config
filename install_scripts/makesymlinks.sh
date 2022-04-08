#!/bin/bash

dir=~/.config
olddir=~/dotfiles_old
files="zshrc p10k.zsh tmux.conf"

[ -d "$dir" ] || echo "No .config dir found"

# backup existing files
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir && echo "done"

cd $dir
echo "Moving any existing dotfiles from ~ to $olddir"

# backup files and symlink
for file in $files; do
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
