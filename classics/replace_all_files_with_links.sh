#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/source_directory"
    exit 1
fi

source_dir="$1"
script_name="$0"
# Check if the provided directory exists and is a directory
if [ ! -d "$source_dir" ]; then
    echo "Error: The directory '$source_dir' does not exist or is not a directory."
    exit 1
fi

# Check if the directory contains any files
if [ -z "$(ls -A "$source_dir")" ]; then
    echo "Error: The directory '$source_dir' is empty."
    exit 1
fi

for filename in	./*; do
	if [ "$(basename "$filename")" == "$script_name" ]; then
        continue
    fi
	# Check if the file exists in the source directory
	if [ -e "$source_dir/$filename" ]; then
    	echo "The file '$filename' already exists in '$source_dir'."
	else
    	echo "The file '$filename' does not exist in '$source_dir'. Creating file:"
		touch $source_dir/$filename
	fi
	if [ -e "$filename" ]; then
		rm "$filename"
	fi	

	ln -s "$filename" "$(basename "$filename")"
done
