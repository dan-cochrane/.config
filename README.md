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

## Keymaps

### Neovim



### lsp

gd - go to definition
gD - go to global declaration
gi - get implementation
gl - get line diagnostics
gr - go to references
]d - go to next diagnostic

### nvim-lsp-installer

<enter> - expand server
i - install server
u - update server
U - update all servers
X - uninstall server 

# tmux

c - create new window
n/p - move to next/previous window
0-9 - move to window number 0-9
l - move to previously selected window
f - find window by name
w - menu with all windows
& - kill current window
, - rename window
% - split window, adding a vertical pane to the right
" - split window, adding an horizontal pane below
q - show pane numbers (used to switch between panes)
o - switch to the next pane
?/? - move focus to left/right pane
?/? - move focus to upper/lower pane
! - Break current pane into new window
x - Kill the current pane.
d - detach the current client
? - list all keybindings
? - show tmux key bindings

# Autocopy SSH keys for WSL
Script to automatically copy the .ssh folder and change permissions to 600 for keys on detecting folder in linux

# Update settings.json for WSL

Logic:
```
    cp -r /mnt/c/Users/xxx/.ssh ~/.ssh
    if [ -d ~.ssh ] || [ -d /mnt/c/Users/xxx/.ssh ]; then 
    cd ~/.ssh
    foreach {$file in $filename.*}
        chmod 600 ~/.ssh/id_ed25519
    done
fi
