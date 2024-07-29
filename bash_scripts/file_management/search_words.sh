#!/bin/bash

## Description
# This Bash script searches for specific words or phrases in all files with a specified extension within a given directory.
# It also checks if the file exists; if it doesn't, it notifies you.
# Change these variables accordingly: `SEARCH_DIRECTORY`, `SEARCH_WORDS`, and `FILE_EXTENSION`.

# Directory to search in
SEARCH_DIRECTORY="/path/example/example"

# Word(s) to search for
# This variable is used to store the phrase or word you would like to search
SEARCH_WORDS="put what you would like to search"

# File extension to search: .txt, .log, .sh
FILE_EXTENSION=".txt"

# Function to search for the specific words in a file
search_in_file() {
  local file="$1"  # Assign the first argument to the 'file' variable

  if [[ -f "$file" ]]; then  # Check if the file exists
    echo "Searching in file: $file"
    
    # Search for the phrase and suppress error messages
    grep -Hn "$SEARCH_WORDS" "$file" 2>/dev/null
    
    # Check the exit status of grep
    if [[ $? -ne 0 ]]; then
      echo "No matching words found in $file"
    fi
  else
    echo "File does not exist: $file"
  fi
}

# Main script logic
if [[ -d "$SEARCH_DIRECTORY" ]]; then  # Check if the directory exists

  # Loop over each file with the specified extension in the directory
  for file in "$SEARCH_DIRECTORY"/*"$FILE_EXTENSION"; do
    search_in_file "$file"
  done
else
  echo "Directory does not exist: $SEARCH_DIRECTORY"  # Notify if the directory does not exist
  exit 1  # Exit the script with an error status
fi

