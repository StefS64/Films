#!/bin/bash

# Check if the user provided a directory as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/source_directory"
    exit 1
fi

source_dir="$1"


if [ -z "$(ls -A "$source_dir")" ]; then
    echo "Error: The directory '$source_dir' is empty."
    exit 1
fi


# Loop through the files in the provided directory
for filename in "$source_dir"/*; do
    ln -s "$filename" "$(basename "$filename")"
done

