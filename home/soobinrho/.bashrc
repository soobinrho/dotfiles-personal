# .bashrc

# ------------------------------------- #
# Default .bashrc
# ------------------------------------- #

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# ------------------------------------- #
# Anaconda
# ------------------------------------- #

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/soobinrho/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/soobinrho/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/soobinrho/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/soobinrho/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ------------------------------------- #
# Aliases
# ------------------------------------- #
alias vim=nvim
alias oldvim=\vim
alias ls='colorls -A'
alias PullGitAll=~/git/bash-git-pull-in-every-folder/PullGitAll
alias StatusGitAll=~/git/bash-git-pull-in-every-folder/optional-scripts/StatusGitAll
alias BuildJava=~/git/college-programming/summer-2022/computer-science-II/BuildJava

# ------------------------------------- #
# GNU GPG Configuration
# ------------------------------------- #
export GPG_TTY=$(tty)

# ------------------------------------- #
# Sourcing for Bash PureLine.
# https://github.com/chris-marsh/pureline
# ------------------------------------- #
if [ "$TERM" != "linux" ]; then
    source ~/pureline/pureline ~/.pureline.conf
fi

# ------------------------------------- #
# Loading z.lua
# https://github.com/skywind3000/z.lua
# ------------------------------------- #
eval "$(lua ~/.local/z.lua/z.lua --init bash enhanced once fzf)"

# ------------------------------------- #
# Loading fzf
# https://github.com/junegunn/fzf.git
# ------------------------------------- #
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ------------------------------------- #
# Configuring nvm.
# https://github.com/nvm-sh/nvm#installing-and-updating
# ------------------------------------- #
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
