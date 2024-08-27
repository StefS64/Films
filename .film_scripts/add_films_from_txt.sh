#!/bin/bash

# The script adds all movie titles from the .txt file as a seperate files without the extension. 

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input_file.txt>"
  exit 1
fi

# Check if the input file exists
input_file="$1"
if [ ! -f "$input_file" ]; then
  echo "Error: File '$input_file' not found!"
  exit 1
fi

# Create the all_films directory if it doesn't exist
mkdir -p all_films

# Read each line from the input file
while IFS= read -r movie_title; do
  # Clean the movie title to be used as a filename (replace spaces with underscores)
  file_name=$(echo "$movie_title" | tr ' ' '_')

  # Create an empty file with the movie title as its name
  touch "all_films/$file_name"

  # Set the permissions to 644
  chmod 644 "all_films/$file_name"
done < "$input_file"

echo "All movies have been added to the all_films directory."