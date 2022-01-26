# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Keep 50000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
zle_highlight=('paste:none')
unsetopt BEEP

# ctrl arrow keys work like bash
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# git aliases
alias g="git"
alias gl="git pull"
alias gp="git push"
alias gcm="git checkout master"
alias gba="git branch -a"
alias ga="git add"
alias gs="git status"
alias gc="git commit -m"
alias gb="git branch"
alias gup="git fetch && git rebase"
alias grhh="git reset HEAD --hard"

# general aliases
alias c="clear"
alias vm="ssh -t danc@danc.dev-vms.speechmatics.io 'zsh -l'"

# source themes and plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme
