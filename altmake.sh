#!/bin/bash
set -eu

DIR=$(pwd)
SHADIR=$(echo $DIR | shasum -a 256 | sed "s/  -//")-${DIR##*/}
TASK=${1:-default}

if [ $TASK = "--help" ] || [ $TASK = "default" -a ! -f  ~/.altmake/$SHADIR/default.sh ];then
    cat <<EOF
$(basename ${0}) works like make commands for the current directory.

Usage:
$(basename ${0}) [command] [<options>]
    Executes ~/.altmake/\${hashed-currentdir}/\${command}.sh with options.
$(basename ${0}) ls
    Print list of commands for the current directory.
$(basename ${0}) edit [command]
    Edit ~/.altmake/\${hashed-currentdir}/\${command}.sh with VSCode.
$(basename ${0}) rm [command]
    Remove  ~/.altmake/\${hashed-currentdir}/\${command}.sh
$(basename ${0}) --help
    Print this
EOF
    exit 0
fi

if [ $TASK = "edit" ];then
    if [ ! -e  ~/.altmake/$SHADIR/ ]; then
        mkdir -p ~/.altmake/$SHADIR
    fi
    SUBTASK=${2:-default}
    if which code > /dev/null 2>&1; then
        command code ~/.altmake/$SHADIR/$SUBTASK.sh
    else
        command vi ~/.altmake/$SHADIR/$SUBTASK.sh
    fi
    exit 0
fi

if [ ! -e  ~/.altmake/$SHADIR/ ]; then
    echo "No commands for the current directory. Please execute 'altmake edit [command]'"
    exit 1
fi

if [ $TASK = "rm" ];then
    SUBTASK=${2:-default}
    if [ -f  ~/.altmake/$SHADIR/$SUBTASK.sh ]; then
        command rm ~/.altmake/$SHADIR/$SUBTASK.sh
        exit 0
    else
        echo "No such commands for the current directory."
        exit 1
    fi
    command code ~/.altmake/$SHADIR/$SUBTASK.sh
    exit 0
fi

if [ $TASK = "ls" ];then
    command ls ~/.altmake/$SHADIR/ | sed "s/\.sh//"
    exit 0
fi

if [ ! -e  ~/.altmake/$SHADIR/$TASK.sh ]; then
    echo "No such commands for the current directory. Available commands are..."
    echo
    command ls ~/.altmake/$SHADIR/ | sed "s/\.sh//"
    exit 1
fi

PARAMS=$(echo $@ | sed "s/$1//g")
command sh ~/.altmake/$SHADIR/$TASK.sh $PARAMS
