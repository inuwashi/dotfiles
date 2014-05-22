#History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt appendhistory autocd extendedglob

# default apps
  (( ${+BROWSER} )) || export BROWSER="w3m"
  (( ${+PAGER} ))   || export PAGER="most"

# Prompt Color 

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
#    export PS1="$WINDOW:%~%# "
    export PS1="[$WINDOW:$PR_BLUE%n$PR_WHITE@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
    export RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
else
#    export PS1='%~ %# '
    export PS1="[$PR_BLUE%n$PR_WHITE@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
    export RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
fi


# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

# vi editing
bindkey -v

# Fix Del, Backspace, Home and Del

#key setups
## bindkey SO HERE'S HOW I CONFIGURED THE PROMPT FOR ZSH:-v # vi key bindings
bindkey -e # emacs key bindings
bindkey ' ' magic-space # also do history expansion on space


# setup backspace correctly
stty erase `tput kbs`

#delete key
bindkey '\e[3~' delete-char

#home
bindkey '\e[1~' beginning-of-line #really dependent of the
#end
bindkey '\e[4~' end-of-line

#insert
bindkey '\e[2~' overwrite-mode

#tab completion
bindkey '^i' expand-or-complete-prefix

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -U compinit
compinit

# aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias scp='nocorrect scp'
alias mkdir='nocorrect mkdir'
alias j=jobs
#if ls -F --color=auto >&/dev/null; then
#  alias ls="ls --color=auto -F"
#else
#  alias ls="ls -F"
#fi
alias l.='ls -d .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'
alias po='popd'
alias pu='pushd'
alias tsl="tail -f /var/log/syslog"
alias df="df -hT"
alias em="emacs -nw"

alias slrn="slrn -n"
alias man='LC_ALL=C LANG=C man'
alias f=finger
alias l='ls -alh'
alias ls='ls --color=auto '
alias rest2html-css='rst2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/s5_html/themes/default/print.css'
alias py='python'
alias x='exit'

# Servers

alias webs='ssh inuwashi@inuwashi.net'
alias gps='ssh gallantpartners@gallantpartners.com'
alias devs='ssh adam@dev.gallantpartners.com'
alias devm='ssh media@dev.gallantpartners.com'
alias devdj='ssh dj-projects@dev.gallantpartners.com'
alias gfxs='ssh adam@192.168.1.2'
alias mthosts='ssh adam@65.98.103.26'
alias vm2s='ssh vm@65.98.103.26'
alias cfns='ssh c21843@www.corporatefamilynetwork.com -p 33988'
alias vmfs='sshfs adam@host.gallantfx.com:/var/vm /media/gfxhost -p 10001'
alias homefs='sshfs adam@host.gallantfx.com:/home/adam /media/gfxhome -p 10001'
alias devfs='sshfs adam@dev.gallantpartners.com:/var/www/localhost /media/devsrv -p 10002'

# Screen
alias s="screen -S"                 # Starts screen
alias 'r'="screen -r"             # Screen Reattach
alias sls="screen -ls"                 # Screen Detach


# functions
mdc() { mkdir -p "$1" && cd "$1" }
setenv() { export $1=$2 }  # csh compatibility
sdate() { date +%Y.%m.%d }
pc() { awk "{print \$$1}" }
rot13 () { tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" }

# shuffle input lines. Nice for mp3 playlists etc...
shuffle() {
  RANDOM=`date +%s`
  (
  while IFS= read -r i; do
    echo $RANDOM$RANDOM "$i";
  done
  ) | sort | sed 's/^[0-9]* //'
}

  
