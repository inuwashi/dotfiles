# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return


#History
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt autocd extendedglob
#share hsitory bewtween screens
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
setopt NOCLOBBER

# Don’t nice background processes
setopt NO_BG_NICE

# Watch other user login/out
watch=notme
export LOGCHECK=60


# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors 2> /dev/null` ]]; then
	eval `dircolors -b`
	alias 'ls=ls --color=auto'
    fi
fi


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

# Set less options
if [[ -x $(which less 2> /dev/null) ]]
then
    export PAGER="less"
    export LESS="--ignore-case --LONG-PROMPT --QUIET --chop-long-lines -Sm --RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
    export LESSHISTFILE='-'
    if [[ -x $(which lesspipe 2> /dev/null) ]]
    then
	LESSOPEN="| lesspipe %s"
	export LESSOPEN
    fi
fi



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
alias e="emacs -nw"

alias man='LC_ALL=C LANG=C man'
alias f=finger
alias l='ls -alh'
alias ls='ls --color=auto '
alias rest2html-css='rst2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/s5_html/themes/default/print.css'
alias py='python3'
alias x='exit'



# For convenience
alias 'mkdir=mkdir -p'
alias 'dmesg=dmesg --ctime'
alias 'df=df -hT --exclude-type=tmpfs'
alias 'dus=du -msc * .*(N) | sort -n'
alias 'dus.=du -msc .* | sort -n'
alias 'fcs=(for i in * .*(N); do echo $(find $i -type f | wc -l) "\t$i"; done) | sort -n'
alias 'fcs.=(for i in .*; do echo $(find $i -type f | wc -l) "\t$i"; done) | sort -n'
alias 'last=last -a'
alias 'zap=clear; echo -en "\e[3J"'
alias 'rmedir=rmdir -v **/*(/^F)'
alias 'ps=ps aux'
alias 'psaux=ps aux'
alias 'fucking=sudo'


# Screen
alias s="screen -S"                 # Starts screen
alias 'r'="screen -r"             # Screen Reattach
alias sls="screen -ls"                 # Screen Detach


# functions
mdc() { mkdir -p "$1" && cd "$1" }
setenv() { export $1=$2 }  # csh compatibility
sdate() { date +%Y.%m.%d }




# Automatically background processes (no output to terminal etc)
z () {
    grey='\e[1;30m'
    norm='\e[m'
    outfile=$(mktemp --tmpdir ${1//\//}.XXX)
    echo "$grey$* &> $outfile$norm"
    $* &>! $outfile &!
}

# Aliases to use this
# Use e.g. 'command gv' to avoid
for i in acroread akregator amarok ario chromium-browser dolphin easytag eclipse firefox gimp gpdf gv gwenview k3b kate konqueror kwrite libreoffice okular opera see; do
    alias "$i=z $i"
done
alias "lo=z libreoffice"

#if test -n "$STY"; then ; else screen; fi

#Vitual Env Wrapper
source "/usr/local/bin/virtualenvwrapper.sh"
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
