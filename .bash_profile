if [ `uname` = "Linux" ]; then
    export PATH=$PATH:/home/john/devel/adt/sdk/platform-tools:/home/john/devel/adt/sdk/tools
    alias git='LC_ALL=en_US.utf8 git'
fi

function parse_git_dirty {
    [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "+"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/@\1$(parse_git_dirty)/"
}

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[1;34m\]\w\[\033[1;33m\]$(parse_git_branch)\[\033[1;34m\]$\[\033[00m\] '
