export PATH=$PATH:$HOME/devel/adt/sdk/platform-tools:$HOME/devel/adt/sdk/tools

if [ `uname` = "Linux" ]; then
    alias git='LC_ALL=en_US.utf8 git'
fi

alias acat='adb logcat -C -v time -s'

function parse_git_dirty {
    [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "+"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/@\1$(parse_git_dirty)/"
}

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[1;34m\]\w\[\033[1;33m\]$(parse_git_branch)\[\033[1;34m\]$\[\033[00m\] '