export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups
shopt -s histappend

alias less='less -i'
alias ls='ls --color=auto'
alias iotop='sudo iotop -o'
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
alias wallpaper-img='feh --no-fehbg --bg-center "`cat /home/j/.wallpaper`"'
alias wallpaper-blank='feh --no-fehbg --bg-tile /home/j/bin/.white.png'
alias fplog='tail -n 0 -f ~/.macromedia/Flash_Player/Logs/flashlog.txt 2>/dev/null'
alias fp='flashplayerdebugger *.swf 2> /dev/null'
alias stoptv='sudo systemctl stop mythbackend.service'
alias pb="curl -F 'sprunge=<-' http://sprunge.us"

show () {
    declare -f "$1" || alias "$1"
}

fix-perms () {
    find "$1" -type d | xargs chmod 755
    find "$1" -type f | xargs chmod 644
}

aur-sync-git () {
    aur-sync -f $(pacman -Qm | while read line; do
        pkg=($line)
        if echo ${pkg[1]} | egrep -q '^[[:digit:]]{8}-[[:digit:]]+$' \
           || echo ${pkg[0]} | grep -q -- '-git$' \
           || echo ${pkg[0]} | grep -q -- '-hg$' \
           || echo ${pkg[0]} | grep -q -- '-bzr$'; then
            if [ ${pkg[0]} != supermeatboy ]; then
                echo ${pkg[0]}
            fi
        fi
    done)
}

ytdl () {
    pushd ~/media/videos/yt &> /dev/null
    youtube-dl -t --max-quality 22 --prefer-free-formats "$@"
    popd &> /dev/null
}

ytdl-low () {
    pushd ~/media/videos/yt &> /dev/null
    youtube-dl -t --max-quality 18 --prefer-free-formats "$@"
    popd &> /dev/null
}

nethogs () {
    [ "`tail /sys/class/net/wlan0/operstate`" = "up" ] && device=wlan0
    sudo nethogs $device
}

gitar () {
    name=$(basename $(readlink -f ..))
    if [ -z "$2" ]; then
        ext=tar.gz
    else
        ext=$2
    fi
    git archive HEAD --prefix="$name-$1/" -o"../$name-$1.$ext"
}

fl () {
    if [ -z "$1" ]; then
        n=`flash`
        if [ -z "$n" ]; then
            # nothing to play
            return
        else
            # play first video
            n=`echo $n | head -n1 | cut -d" " -f1`
        fi
    else
        # got video to play
        n=$1
    fi
    flash $n vlc
}

flcp () {
    flash | cut -d" " -f1 | while read num; do
        flash "$num" "cp -t ."
    done
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
    pat="$1"
    shift
    find . -regextype posix-extended -iregex ".*$pat.*" "$@"
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

export PYTHONPATH=$PYTHONPATH:"$HOME/Documents/Coding/Python modules"

export EDITOR=/usr/bin/vim
export GREP_OPTIONS='--color=auto'
export JAR=fastjar
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0

export PATH="$HOME/bin:$PATH"

PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

irccmd=weechat-curses
if [ "$STARTIRC" = "y" ]; then
    exec "$irccmd"
elif [ "$STARTIRC" = "n" ]; then
    exec "$irccmd" -a
fi
if [ "$STARTIRCREMOTE" = "y" ]; then
    irc () {
        TERM=xterm-256color ssh $host "bash -l -c 'tmux attach'" && exit
    }

    host=rpi irc || host=home irc
fi
