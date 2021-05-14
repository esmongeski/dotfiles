#!/usr/bin/env bash

# Heyo this is my bash profile. I make a toooon of personal scripts for ease of use.

# I wanted to use this, but never really ended up doing it. Decent for quick aliases if you're just trying stuff out in the shell.
alias a='alias'

# Shortcuts for local config files. Usually I make these files point at something in this repo on any given machine I'm working on
alias vlv='vim ~/.vimrc'
alias ele='emacs ~/.emacs'
alias vle='vim ~/.emacs'
alias vlbp='vim ~/.bash_profile'
alias slbp='echo "sourcing LOCAL bash profile"; . ~/.bash_profile'

# Shortcuts for config files in this directory. These require the aliases used to be defined locally so this can figure out the path
alias ee='emacs $PATH_TO_EDITABLE_DOT_EMACS'
# Gotcha, this is now an org file usually so use emacs
alias ve='echo $PATH_TO_EDITABLE_DOT_EMACS; emacs $PATH_TO_EDITABLE_DOT_EMACS'
alias vv='echo `path_to_vimrc`; vim `path_to_vimrc`'

alias sbp='echo "sourcing bash profile"; . `path_to_bash_profile`' # this is great when adding new stuff here
alias vbp='vim `path_to_bash_profile`'  #same as above

# Stolen from @dubennett https://github.com/dusbennett/terminal-commands/blob/master/shell/.profile
alias cd..='cd ..'
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# I always mess up "grep -r stuff ." and "grep -r . stuff"
# vendor is an exclusion of php libraries - I should probably add other libarary directories
# but I'm mostly writing php day to day
function grd() {
  grep -r -i --exclude-dir={vendor,.git,.idea} $1 . | grep -v vendor
}

alias lsg='ls | grep'

# Hook to add interesting things - at one point someone wrapped git in timing to prove how awful our repo was
alias g='git'

alias unstage="g reset HEAD"
alias gpush='echo "ted you typed too fast"; g push;'

# Git add and commit with message
function gca(){
  g add .; git commit -m "$*";
}

alias gp='g push'

function echoAndEval {
	echo $1
	eval $1
}

# Some git repos still use master - this lets me not think which is which
function gcm {
        RESULT=`git rev-parse --verify main`
        if [ -z $RESULT ];
        then
                echo "main is not a branch, checkin out master"
                echoAndEval "g checkout master"
        else
                echo "main is a branch, checking it out"
                echoAndEval "g checkout main"
        fi
}

alias brs='g branch -vv' # list branches
alias gs='g status' #obvious
alias gc='g checkout' #obv
alias gl='g log'
alias glf='gl --name-only' #git log show files
# current git branch
#alias cb='git rev-parse --abbrev-ref HEAD'
alias cb='parse_git_branch' #can't remember what this was originally for

alias sd=shortdate
alias gd='g diff' # obvious
alias gds='g diff --staged' #use this to check whats on a train (or staged on any branch. but who uses this for anything else?)
alias gdo='g diff origin/`cb`' # Use this after committing to a branch to diff with the origin version
alias gms='g merge --squash' # Use this a lot
alias gf='g fetch'

alias emacs='emacs -nw' # no window for emacs


# all this swap stuff was a thing I tried to use to make swapping between two branches easier. It ended up not being super great.
# gchlike on the other hand, has made swapping branches super super easy.
alias oswp='echo $OLDBRANCH; echo "gswp to change, setswbranch to change oldbranch"'
alias swbr='echo $OLDBRANCH'
# part of the whole oswp thing; really not useful
export OLDBRANCH=masteri

alias rgi='rm .git/index.lock'

# dont remove git index, terrible things will happen
function rm {
    if [ $1 == ".git/index" ]; then
      echo "NOOOOOO"
    else
      command rm "$@"
    fi
}

# command line COLORS!
export PS1="\[\e[32;40m\]\u\[\e[m\]@\[\e[31;40m\]\h\[\e[m\]\[\e[36;40m\]\w\[\e[m\]\[\e[35;40m\] (\$(cb))\[\e[m\] $ "

# count the files in a directory
function countfiles {
    ls -1 $1 | wc -l | tr -d '[:space:]'
}

function findLinkAndOpen {
    splitOutput "$1" | grep https | xargs open
}

function splitOutput {
    for token in $1
    do
      echo $token
    done
}

# This thing is super great. Give it a short string, and it greps your git branches for that string. If it finds exactly
# one match, it checks out that branch. Otherwise it tells you what it did find you can refine your query (or just copy
# the branch you want)
function gchlike {
    local MATCHES=`g branch | grep -i $1 | awk '{print $1;}'`
    local MATCHCOUNT=`echo "$MATCHES" | wc -l`
    if [ "$MATCHCOUNT" -gt 1 ]; then
        echo "Too many branches!"
        echo "$MATCHES"
    elif [ "$MATCHES" == "" ]; then
        echo "No branches!"
    else
        echo "checking out $MATCHES"
        g checkout "$MATCHES"
    fi
}

alias shortdate='date +%Y-%m-%d' # get date in format YYYY-MM-DD



# If you're in the middle of a pull/rebase and run into a conflict, this should back you out of it
function idontwannamerge {
    g reset HEAD;
    g clean -f -d;
    g checkout *
    # WTF is this? who knows, but it keeps showing up
    gc .gitlab-ci.yml
}


alias undocommitanddelete="g reset HEAD^; g checkout *; g clean -f -d"
alias undocommit="g reset HEAD^"

# parse out the current git branch. i stole this from somewhere on the internet, i'm not that good at bash fu
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function partyify {
    while [[ $# -gt 1 ]]
    do
    key="$1"
      case $key in
      -i|--input-file)
      INPUTFILE=$2
      shift
      ;;
      -c|-color)
      COLOR=$2
      shift
      ;;
      -f|--fuzz)
      FUZZ=$2
      shift
      ;;
      -o|--output-file)
      OUTPUTFILE=$2
      shift
      ;;
      *)
        # unknown arg
      ;;
    esac
    shift
    done

    echo Input - "${INPUTFILE}"
    party_colors=("#93FE90" "#8FB3FC" "#CF7CFA" "#EF4CEF" "#F1586A" "#F9D48D")
    for i in "${!party_colors[@]}"
    do
      echo   magick convert "${INPUTFILE}" -fill "${party_colors[i]}" -fuzz "${FUZZ}"% -opaque "${COLOR}" party_temp-"$((i+1))".png
      magick convert "${INPUTFILE}" -fill "${party_colors[i]}" -fuzz "${FUZZ}"% -opaque "${COLOR}" party_temp-"$((i+1))".png
      echo Making party_temp-"$((i+1))".png, replacing "${COLOR}" with "${party_colors[i]}"
    done
    magick convert party_temp-%d.png[1-"${#party_colors[@]}"] -set delay 10 -loop 0 "${OUTPUTFILE}"
    echo "${OUTPUTFILE} has been created."
}
