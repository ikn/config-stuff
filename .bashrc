export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups
shopt -s histappend

alias less='less -i'
alias ls='ls --color=auto'
alias iotop='sudo iotop -o'
alias ssh='ssh -t'
alias sed='sed -r'
alias ag='ag -i'

alias pacman='pacman'
alias inst='sudo pacman -S'
alias uninst='sudo pacman -Rs'
alias up='sudo pacman -Syu'
alias lookfor='pacman -Ss'
alias owned='pacman -Qo `find .` 2>&1 | grep -v ^error'

alias l='ls'
alias py='python'
alias py2='python2'
alias lock='echo try vlock'
alias fcsh-wrap='fcsh-wrap -optimize=true -static-link-runtime-shared-libraries=true'
alias fcsh-wrap-dbg='fcsh-wrap -compiler.debug=true'
alias wproxy='ssh -D 8080 wp'
alias :q='exit'

alias aoeu='setxkbmap gb'
alias asdf='setxkbmap gb dvorakukp'
alias freq='grep MHz /proc/cpuinfo'
alias searchin='echo use ag; true'
alias mrefresh='mpc || mpd; mpc clear && mpc ls | mpc add'
alias wallpaper-img='feh --no-fehbg --bg-center "`cat /home/j/.wallpaper`"'
alias wallpaper-blank='feh --no-fehbg --bg-tile /home/j/bin/.white.png'
alias fplog='tail -n 0 -f ~/.macromedia/Flash_Player/Logs/flashlog.txt 2>/dev/null'
alias fp='flashplayerdebugger *.swf 2> /dev/null'
alias stop_net='killall nm-applet mail-notification thunderbird firefox; sudo systemctl stop crashplan.service dcron.service NetworkManager.service chrony.service'
alias stop_tv='sudo systemctl stop mythbackend.service'
alias pb="curl -F 'sprunge=<-' http://sprunge.us"

aur-sync-git () {
    aur-sync -f $(pacman -Qm | while read line; do
        pkg=($line)
        if echo ${pkg[1]} | egrep '^[[:digit:]]{8}-[[:digit:]]+$' > /dev/null \
           || echo ${pkg[1]} | grep -- '-git$' > /dev/null; then
            if [ ${pkg[0]} != supermeatboy ]; then
                echo ${pkg[0]}
            fi
        fi
    done)
}

ytdl () {
    pushd ~/media/videos &> /dev/null
    youtube-dl -t --max-quality 44 --prefer-free-formats "$@"
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
    TERM=xterm ssh codd "tmux attach"; exit
fi
