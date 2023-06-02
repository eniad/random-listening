#!/bin/bash
# Echo random match to string, default '[ ]', in dir, default '.'
# useage:
#   ./random-listening.sh [dir] [string]
# options:
#   dir - searches files or directories, two levels deep, that match the input
#       exp: 'prog' will match content/genre/prog-metal.md and content/genre/prog-rock/* and content/recommentations/greatest-prog-albums.md and more
#   string - expression to match. requires dir first

if [[ $# -ge 1 ]]
then
    dir="*/$1*"
else
    dir='.'
fi

if [[ $# -eq 2 ]]
then
    string=$2
else
    string='\[[ |-]\]'
fi

readarray -t array < <(grep -irn "$string" $dir)

size=${#array[@]}
index=$(($RANDOM % $size))

echo $dir ${array[$index]}
