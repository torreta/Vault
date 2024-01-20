#!/bin/bash

# Function to list files recursively
list_files_recursive() {
    local dir="$1"

    # Iterate over files and directories in the given directory
    for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
            # If it's a file, write the filename to the output file
            echo "$file" >> "$output_file"
        elif [[ -d "$file" ]]; then
            # If it's a directory, recursively call the function
            list_files_recursive "$file"
        fi
    done
}

# Check if the folder path is provided as an argument
if [[ -z "$1" ]]; then
    echo "Please provide a folder path as an argument."
    exit 1
fi

folder_path="$1"

# Check if the provided folder exists
if [[ ! -d "$folder_path" ]]; then
    echo "The specified folder does not exist."
    exit 1
fi

# Check if the output file path is provided as an argument
if [[ -z "$2" ]]; then
    echo "Please provide an output file path as the second argument."
    exit 1
fi

output_file="$2"

# Clear the output file if it already exists, or create a new one
> "$output_file"

# Call the function to list files recursively
list_files_recursive "$folder_path"

echo "File listing completed. The output is saved in: $output_file"