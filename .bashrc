PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools
export PATH

if [ `uname` = "Linux" ]; then
    alias git='LC_ALL=en_US.utf8 git'
    alias gatherxmpp='~/.mcabber/log.sh gather'
    alias gmailxmpp='~/.mcabber/log.sh gmail'
fi

alias gr='grep -Ir'
alias gri='grep -Iir'
alias acat='adb logcat -C -v time -s'

function parse_git_dirty {
    [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "+"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/@\1$(parse_git_dirty)/"
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[1;34m\]\w\[\033[1;33m\]$(parse_git_branch)\[\033[1;34m\]$\[\033[00m\] '
export PS1
