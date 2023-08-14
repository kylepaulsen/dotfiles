alias ..='cd ..'
alias sha1='openssl sha1'
alias untargz='tar -xvzf'

alias day='redshift -P -O 8000 -m randr'
alias night='redshift -P -O 2000 -m randr'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
# alias lx='ls -lXB'         #  Sort by extension.
# alias lk='ls -lSr'         #  Sort by size, biggest last.
# alias lt='ls -ltr'         #  Sort by date, most recent last.
# alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
# alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv"
# alias lm='ll |more'        #  Pipe through 'more'
# alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
# alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


# Git branch in prompt.

export myblue=$(tput setaf 6)
export mygreen=$(tput setaf 2)
export myreset=$(tput sgr0)

get_git_repo() {
    wd=$PWD
    while [[ "$wd" != '/' ]]; do
        if [ -d "$wd/.git" ]; then
            echo $(basename "$wd")
            break;
        else
            wd=$(realpath "$wd/..")
        fi
    done;
}

make_git_prompt() {
    branch=$(git status 2> /dev/null | head -n 1 | sed 's/On branch \(.*\)/\1/')
    if [ ! -z "$branch" ]; then
        repo=$(get_git_repo)
        printf "($repo - $branch) "
    fi
}

export PS1="\u@\h \[$myblue\]\W \[$mygreen\]\$(make_git_prompt)\[$myreset\]$ "

search() {
    target=$1
    searchFor=$2
    if [ -z "$2" ]; then
        target="."
        searchFor=$1
    fi
    find $target -type f | grep -F $searchFor
}

e() {
    if [ -z "$1" ]; then
        target=$(rg --files | fzy)
    else
        target=$(rg --files | fzy -q $1)
    fi
    if [ ! -z "$target" ]; then
        edit $target
    fi
}

mkzip() {
    base=$(basename "$1")
    zip -r "$base.zip" "$1"
}

export RIPGREP_CONFIG_PATH=~/.config/ripgrep/.ripgreprc
