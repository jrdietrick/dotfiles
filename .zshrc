export ZSH=$HOME/.omz

ZSH_THEME="jrdietrick"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=()

export HOSTNAME=$(hostname -s)

# Bash-compatible baseline
source $HOME/.bashrc > /dev/null 2>&1

# Bring in host-specific stuff
source $HOME/.zshrc.$HOSTNAME > /dev/null 2>&1

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Fix Alt+Left and Alt+Right bindings
bindkey "^[^[OC" forward-word
bindkey "^[^[OD" backward-word
