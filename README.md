## Dotfile management
- Write shell scripts for configs (tmux, zshrc, etc)
- Write set-up script for sourcing shell script to relevant dotfile
- Install/deploy scripts to run the set-up scripts
- Symlink the sm-dotfiles repo into the .configs file
    - need to only Symlink the non-tmux configs

## tmux

` - prefix

### window commands
c - create new window \
& - kill current window \
0-9 - move to window number 0-9 \
n/p - move to next/previous window \
w - menu with all windows \
, - rename window

### pane commands

Note I don't move with ctrl + vim

| - split vertically \
\- - split horizontally \
x - Kill the current pane. \
h - move to left pane \
j - move to lower pane \
k - move to upper pane \
l - move to right pane \
q - show pane numbers (used to switch between panes) \
o - switch to the next pane \
! - Break current pane into new window

### general
d - detach the current client \
? - list all keybindings 

