PATH=$PATH:$HOME/bin

NUM_CORES=`cat /proc/cpuinfo | grep -E "^processor\\s+:\\s+[0-9]+$" | wc -l`

function parse_git_dirty {
    [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "+"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/@\1$(parse_git_dirty)/"
}

function find_git_home {
    git rev-parse --show-toplevel 2> /dev/null
}

function go_to_git_home {
    cd $(find_git_home)
}

function activate_venv {
    venv_home=$(find_git_home)
    if [ $? != 0 ]; then
        venv_home=$(pwd)
    fi
    pushd $venv_home
    source venv/bin/activate
    popd
}

function find_file {
    if [ $1 = "case_sensitive" ]; then
        option="-name"
    else
        option="-iname"
    fi
    search_string=$2
    search_path="."
    if [[ $# -gt 2 ]]; then
        search_path=$3
        shift 3
    else
        shift 2
    fi
    find $search_path $option "*$search_string*" $@
}

function open_indexed_file_in_sublime_text {
    sed -n "$1p" | xargs st
}

# Stomp aliases (things which change default arguments for system commands)
alias ls='ls --color'
alias vim='vim -X'

# Convenience aliases
alias acat='adb logcat -C -v time -s'
alias ff='find_file case_insensitive'
alias ffs='find_file case_sensitive'
alias gh='go_to_git_home'
alias gr='grep --color -I --recursive'
alias gri='grep --color -I --ignore-case --recursive'
alias ll='ls -l'
alias ost='open_indexed_file_in_sublime_text'
alias prettyprint_json='python -m json.tool'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[1;34m\]\w\[\033[1;33m\]$(parse_git_branch)\[\033[1;34m\]$\[\033[00m\] '
export PS1

# Initialize RVM (Ruby) if it exists
if [ -d "/opt/rvm/" ]; then
    export PATH="$PATH:/opt/rvm/bin"
    [[ -s "/opt/rvm/scripts/rvm" ]] && source "/opt/rvm/scripts/rvm"
fi

# Caps lock is the worst
xmodmap -e "keycode 66 = Shift_L NoSymbol Shift_L" > /dev/null 2>&1

# Pull in host-specific RC
source $HOME/.bashrc.$HOSTNAME > /dev/null 2>&1
