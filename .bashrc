. ~/.profile

export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups
shopt -s histappend
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

alias less='less -i'
alias ls='ls --color=auto'
alias iotop='sudo iotop -o'
alias nethogs='sudo nethogs enp3s0'
alias ssh='ssh -t'
alias ag='ag -i'
alias free='free -m'
alias info='info --vi-keys'
alias fcsh-wrap='fcsh-wrap -optimize=true -static-link-runtime-shared-libraries=true'
alias fcsh-wrap-dbg='fcsh-wrap -compiler.debug=true'
alias pactree='pactree -c'

alias pac='pacman'
alias paclog='less /var/log/pacman.log'
alias inst='sudo pacman -S'
alias uninst='sudo pacman -Rs'
alias up='sudo pacman -Syu'
alias owned='pacman -Qo `find .` 2>&1 | grep -v ^error'

alias v='vim'
alias l='ls'
alias sedr='sed -r'
alias py='python'
alias py2='python2'
alias lock='echo try vlock'
alias :q='exit'
alias crontab='fcrontab'

alias aoeu='setxkbmap gb'
alias asdf='setxkbmap gb dvorakukp'
alias freq='grep MHz /proc/cpuinfo'
alias fplog='tail -n 0 -f ~/.macromedia/Flash_Player/Logs/flashlog.txt 2>/dev/null'
alias fp='flashplayerdebugger *.swf 2> /dev/null'
alias stoptv='sudo systemctl stop mythbackend.service'
alias pb="curl -F 'sprunge=<-' http://sprunge.us"
alias toggle-redshift='killall -USR1 redshift'

show () {
    declare -f "$1" || alias "$1"
}

fix-perms () {
    for dir in "$@"; do
        find "$dir" -type d | xargs chmod 755 2> /dev/null
        find "$dir" -type f | xargs chmod 644 2> /dev/null
    done
}

aur-sync-git () {
    aur-sync -f $(pacman -Qm | while read line; do
        pkg=($line)
        if echo ${pkg[1]} | egrep -q '^[[:digit:]]{8}-[[:digit:]]+$' \
           || echo ${pkg[0]} | grep -q -- '-git$' \
           || echo ${pkg[0]} | grep -q -- '-hg$' \
           || echo ${pkg[0]} | grep -q -- '-bzr$'; then
            if [ ${pkg[0]} != supermeatboy -a \
                ${pkg[0]} != vessel -a \
                ${pkg[0]} != sokobond ]; then
                echo ${pkg[0]}
            fi
        fi
    done)
}

alias youtube-dl='youtube-dl --prefer-free-formats --max-quality 22'

_ytdl () {
    pushd ~/media/videos &> /dev/null
    until-success 10 youtube-dl -t "$@"
    popd &> /dev/null
}

alias ytdl='_ytdl --no-playlist'
alias ytdl-low='ytdl --max-quality 18'
alias ytdl-playlist='_ytdl -A'
alias ytdl-low-playlist='_ytdl-playlist --max-quality 18'

ytvlc () {
    vlc "$(youtube-dl -g --max-quality 22 --prefer-free-formats "$@")" \
        --meta-title="$(youtube-dl -e "$1")"
}

alias ytvlc-low='ytvlc --max-quality 18'

gitar () {
    name=$(basename "$(readlink -f ..)")
    if [ -z "$2" ]; then
        ext=tar.gz
    else
        ext=$2
    fi
    git archive HEAD --prefix="$name-$1/" -o"../$name-$1.$ext"
}

fl () {
    if [ -z "$1" ]; then
        n=$(flash)
        if [ -z "$n" ]; then
            # nothing to play
            return
        else
            # play first video
            n=$(echo "$n" | head -n1 | cut -d" " -f1)
        fi
    else
        # got video to play
        n="$1"
    fi
    flash "$n" vlc
}

flcp () {
    if [ "$#" -ge 2 ]; then
        dest="$2"
        tmp="$(mktemp -d)"
        flash "$1" cp -t "$tmp"
        mv "$tmp/$1" "$dest"
        rm -rf "$tmp"
    else
        if [ -n "$1" ]; then
            dest="$1"
        else
            dest=.
        fi

        flash | cut -d" " -f1 | while read num; do
            flash "$num" cp -t "$dest"
        done
    fi
}

man () {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

search () {
    ag -ug "$@"
}

sumfs () {
    search "$1" -type f -print0 | grep -zZv /$ | xargs -0 ls -l | \
        awk '{print $5}' | paste -sd+ - | bc
}

vidmem () {
    sudo bash -c '
        for f in /sys/kernel/debug/dri/*/i915_gem_gtt; do
            echo $((`tail -n1 "$f" | cut -d" " -f4`/1024/1024))
        done
    '
}

alias p='python -ic "
import os, atexit, readline, rlcompleter
hist = \"/home/j/.pyhistory\"
def save_history(historyPath = hist):
    import readline
    readline.write_history_file(hist)
atexit.register(save_history)
if os.path.exists(hist):
    readline.read_history_file(hist)
readline.parse_and_bind(\"tab: complete\")
del os, atexit, readline, rlcompleter"'

alias p2='python2 -ic "
import os, atexit, readline, rlcompleter
hist = \"/home/j/.pyhistory\"
def save_history(historyPath = hist):
    import readline
    readline.write_history_file(hist)
atexit.register(save_history)
if os.path.exists(hist):
    readline.read_history_file(hist)
readline.parse_and_bind(\"tab: complete\")
del os, atexit, readline, rlcompleter"'

if [ "$STARTIRCREMOTE" = "y" ]; then
    irc () {
        TERM=xterm-256color ssh $host "bash -l -c 'tmux attach'" && exit
    }

    host=rpi irc || host=home irc
fi
