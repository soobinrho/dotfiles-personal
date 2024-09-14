# ---------------------------------------------------------------------
# Oh My Zsh Configs
# ---------------------------------------------------------------------
# Solve WSL git commit sign prompt bug.
# Source:
#   https://stackoverflow.com/questions/57619460/trying-to-sign-commits-on-git-using-gpg-on-wsl-but-does-not-work
export GPG_TTY=$TTY

# P10k config for tmux autostart. Must stay above p10k-instant-prompt.
# Source:
#   https://github.com/romkatv/powerlevel10k/issues/1203#issuecomment-754805535
if [ -z "$TMUX" ]; then
  exec tmux new-session -A -s mainSession
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

plugins=(
    tmux
    colored-man-pages
)

ZSH_TMUX_AUTOSTART=true

# The source line must come after ZSH_TMUX lines.
source $ZSH/oh-my-zsh.sh

# ---------------------------------------------------------------------
# Command execution history best practices
# ---------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# ---------------------------------------------------------------------
# Customizations
# ---------------------------------------------------------------------
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# By default, in wsl Ubuntu, it was set to 16.
export TERM="screen-256color"

# ---------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------
alias bat="batcat"
alias vim="nvim"
# vim() {
#         (alacritty --command nvim "$1" &)
# }

# Git aliases
# Source:
#   https://github.com/surajssd/dotfiles/blob/master/configs/zshrc
alias gs="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
