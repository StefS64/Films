#!/bin/bash

# Script Name:	replace_all_files_with_links.sh
# Description: Creates simbolik links from one to another directory.
# Author: Stefan Świerczewski
# Date: 2024-08-20


show_help() {
    echo "
	Usage: $(basename "$0") [OPTION]
	
	Options:
	  -h, --help    Show this help message and exit
	  -v, --version Show version information and exit
	
	Description:
	  	This script creates hard links for all files in a link_directory to files in the source_directory
	  	The first argument is the source_directory the second is the link_directory.
		If destroys the files in the link_directory except for hard links.
		Creates a new on in source_dir, if 
	  	such a file doesn't exist it creates a new one. 
	"
}

check_if_valid_directory() {
	local dir="$1"
	if [ ! -d "$dir" ]; then
	    echo "Error: The directory '$dir' does not exist or is not a directory."
	    exit 1
	fi
	
	
	# Check if the directory contains any files
	if [ -z "$(ls -A "$dir")" ]; then
	    echo "Error: The directory '$dir' is empty."
	    exit 1
	fi
}

# No arguments given
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/source_directory /path/to/link_directory

For help use -h  or --help
		"
    exit 1
fi


# Check if help is needed
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

source_dir="$1"
link_dir="$2"
script_name="$0"

check_if_valid_directory "$source_dir"
check_if_valid_directory "$link_dir"



for filename in	"$link_dir"/*; do
	echo	"$filename"
	
	basename_file="$(basename "$filename")"

	#Check if you aren't using this file 
	if [ "$basename_file" == "$script_name" ]; then
        continue
    fi

	# Check if the file exists in the source directory
	if [ -e "$source_dir/$basename_file" ]; then
    	echo "The file '$filename' already exists in '$source_dir'."
	else
    	echo "The file '$filename' does not exist in '$source_dir'. Creating file:"
		touch "$source_dir/$basename_file"
	fi
	
	# Check if the file is a hard_link
#	if [ -e  "$filename"] then
	link_count=$(stat -c '%h' "$filename") 
	if [ "$link_count" -eq 1 ]; then 
		rm "$filename"
	fi
	
	echo "source_dir : $source_dir/$basename_file  link_dir: $link_dir/$basename_file"
	ln "$source_dir/$basename_file" "$link_dir/$basename_file"
done
