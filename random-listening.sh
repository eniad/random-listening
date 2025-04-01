#!/bin/bash
# Echo random match to string, default '[ ]', in dir, default '.'
# useage:
#   ./random-listening.sh [dir] [string]
# options:
#   dir - searches files or directories, two levels deep, that match the input
#       exp: 'prog' will match content/genre/prog-metal.md and content/genre/prog-rock/* and content/recommentations/greatest-prog-albums.md and more
#   string - expression to match. requires dir first

# Directories to exclude
excludes=("instruments" "random-listening")

# Build the exclude options for grep
exclude_opts=()
for exclude in "${excludes[@]}"; do
    exclude_opts+=(--exclude-dir="$exclude")
done

# Set the directory to search
dir="${1:+*/*/*$1*}"
dir="${dir:-.}"

# Set the string to search for
string="${2:-\[[ |-]\]}"

# Perform the search and read results into an array
echo  "Searching in $dir for '$string'..."
readarray -t array < <(grep -sirn "$string" "${exclude_opts[@]}" $dir)

# Check if the array is empty
size=${#array[@]}
if [[ $size -eq 0 ]]; then
    echo "No matches found."
    exit 1
fi

# Select a random match and print it
index=$((RANDOM % size))
echo "$dir ${array[$index]}"
