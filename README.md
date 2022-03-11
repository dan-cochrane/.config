# .config
Repo of dotfiles

# .zshrc
Inspired by: \
https://dev.to/pratik_kale/customise-your-terminal-using-zsh-powerlevel10k-1og5 \
https://github.com/ChristianChiarulli/Machfiles/blob/master/zsh/.zshrc \
https://www.youtube.com/watch?v=bTLYiNvRIVI&ab_channel=ChrisAtMachine

.zshrc to have: \
Powerlevel10k \
zsh-autosuggestions \
zsh-syntax-highlighting \
keychain \

Going to avoid using Oh-my-zsh. Don't need most of the plug-ins and can manage my computer more cleanly this way :)

# .p10k
My customised p10k config

# .gitconfig
Containing all the good git stuff

# Neovim
Using the LunarVim configuration.
Neovim nightly, installed as an app image (chmod +x, mv nvim.appimage nvim, mv nvim /usr/local/bin/)

# Autocopy SSH keys for WSL
Script to automatically copy the .ssh folder and change permissions to 600 for keys on detecting folder in linux

# Update settings.json for WSL

Logic:
```
if [ -d ~.ssh ] || [ -d /mnt/c/Users/xxx/.ssh ]; then 
    cp -r /mnt/c/Users/xxx/.ssh ~/.ssh
    cd ~/.ssh
    foreach {$file in $filename.*}
        chmod 600 ~/.ssh/id_ed25519
    done
fi
