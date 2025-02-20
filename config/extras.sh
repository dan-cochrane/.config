#-------------------------------------------------------------
# zsh extra settings
#-------------------------------------------------------------

# Safety: Force confirmation when using rm with wildcards
setopt RM_STAR_WAIT              # Wait when typing `rm *` before being able to confirm

# Terminal behavior
setopt NO_BEEP                   # Don't beep on errors in ZLE

# History handling and cleaning
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_NO_STORE            # Remove the history (fc -l) command from the history.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.

# Completion behavior
setopt completealiases           # Expand aliases before completion
setopt always_to_end             # Move cursor to end of word after completion
setopt list_ambiguous           # Show completion menu when ambiguous
setopt share_history            # Share history between all sessions

# History size configuration
export SAVEHIST=100000
export HISTSIZE=100000          # Number of commands stored in memory
export HISTFILESIZE=100000      # Number of commands stored in history file

# Process handling
unsetopt hup                    # Don't kill background jobs when shell exits

# Terminal behavior
unsetopt list_beep             # Don't beep when displaying completion list

# Disable hostname completion
zstyle ':completion:*' hosts off

# Ensure HISTFILE is set
if [[ -z "$HISTFILE" ]]; then
    export HISTFILE="${HOME}/.histfile"
fi

# Create the history file if it doesn't exist
if [[ ! -f "$HISTFILE" ]]; then
    touch "$HISTFILE"
fi

# Set Up and Down arrow keys to the (zsh-)history-substring-search plugin
# `-n` means `not empty`, equivalent to `! -z`
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down

# Uncomment this to set the history search to match the prefix. It's used in the zsh-history-substring-search plugin,
# and it just checks if this variable is defined, not what the value is.
# export HISTORY_SUBSTRING_SEARCH_PREFIXED=true

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# ls after every cd
function chpwd() {
 emulate -L zsh
 ls
}


# git add ci and push
function git_prepare() {
   if [ -n "$BUFFER" ]; then
	BUFFER="git add -u && git commit -m \"$BUFFER\" "
   fi

   if [ -z "$BUFFER" ]; then
	BUFFER="git add -u && git commit -v "
   fi

   zle accept-line
}
zle -N git_prepare
bindkey -r "^G"
bindkey "^G" git_prepare
