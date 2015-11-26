PATH=$PATH:/opt/android-sdk/platform-tools:/opt/android-sdk/tools
export PATH

if [ `uname` = "Linux" ]; then
    alias git='LC_ALL=en_US.utf8 git'
    alias gatherxmpp='~/.mcabber/log.sh gather'
    alias gmailxmpp='~/.mcabber/log.sh gmail'
fi

function parse_git_dirty {
    [[ $(git status --porcelain 2> /dev/null | tail -n1) != "" ]] && echo "+"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/@\1$(parse_git_dirty)/"
}

function mount_protected_cifs_share {
    sudo mount.cifs //192.168.0.99/$1/ /media/$USER/$1/ -o "username=$USER,uid=$UID,gid=$UID,file_mode=0600,dir_mode=0700,iocharset=utf8,nounix"
    if [ $? = 0 ]; then
        ls -l /media/$USER/$1/
    fi
}

function find_git_home {
    git rev-parse --show-toplevel 2> /dev/null
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

function go_to_git_home {
    cd $(find_git_home)
}

function g2fa {
    if [ $1 = "gmail" ]; then
        code=`cat ~/.ssh/google_backup_codes_j.r.dietrick@gmail.com | head -n 1`
        echo $code
        echo $code | xsel -i -b
        sed "1d" -i ~/.ssh/google_backup_codes_j.r.dietrick@gmail.com
    elif [ $1 = "gather" ]; then
        code=`cat ~/.ssh/google_backup_codes_john@gatherhealth.com | head -n 1`
        echo $code
        echo $code | xsel -i -b
        sed "1d" -i ~/.ssh/google_backup_codes_john@gatherhealth.com
    fi
}

alias 2fa_gather='g2fa gather'
alias 2fa_personal='g2fa gmail'
alias acat='adb logcat -C -v time -s'
alias gh='go_to_git_home'
alias gr='grep -Ir'
alias gri='grep -Iir'
alias prettyprint_json='python -m json.tool'

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\033[1;34m\]\w\[\033[1;33m\]$(parse_git_branch)\[\033[1;34m\]$\[\033[00m\] '
export PS1

# Initialize RVM (Ruby) if it exists
if [ -d "/opt/rvm/" ]; then
    export PATH="$PATH:/opt/rvm/bin"
    [[ -s "/opt/rvm/scripts/rvm" ]] && source "/opt/rvm/scripts/rvm"
fi
