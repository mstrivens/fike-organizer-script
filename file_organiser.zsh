#!/bin/zsh
echo 'start'
search_directory="/Users/max.strivens/Documents"  # Replace with the actual path to your "documents" folder
automotive_directory="/Users/max.strivens/Documents/Automotive"  # Replace with the path to the "automotive" folder
fashion_directory="path/to/fashion"  # Replace with the path to the "fashion" folder

# Function to check if a file name contains the specified words
# and perform the necessary operations
check_file_name() {
    echo "STARTING"
    local file_path="$1"
    local file_name="$(basename "$file_path")"
    echo "file-name" $file_name
    local file_year="$(ls -l -T "$file_name" | awk '{print $9}')"
    echo "file-year" $file_year

    if [[ "$file_name" == *automotive* ]]; then
        echo "Match found: $file_name"

        # Create subdirectory based on the year if it doesn't exist
        local subdirectory="$automotive_directory/$file_year"
        mkdir -p "$subdirectory"

        # Move the file to the corresponding subdirectory
        mv "$file_path" "$subdirectory"

    elif [[ "$file_name" == *fashion* ]]; then
        echo "Match found: $file_name"

        # Create subdirectory based on the year if it doesn't exist
        local subdirectory="$fashion_directory/$file_year"
        mkdir -p "$subdirectory"

        # Move the file to the corresponding subdirectory
        mv "$file_path" "$subdirectory"
    fi
}

# Recursive function to search files in a directory
search_files() {
    echo "STARTING SEARCH FILES"
    local dir="$1"
    for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
            check_file_name "$file"
        elif [[ -d "$file" ]]; then
            search_files "$file"
        fi
    done
}

# Start searching from the specified directory
search_files "$search_directory"
