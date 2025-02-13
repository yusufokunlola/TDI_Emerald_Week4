#!/bin/bash

# Script Name: Machine Learning Project Template Creator
# Description: This script automates the creation of a structured template for machine learning projects, including directories and files.
# Usage: ./project_template.sh
# Dependencies: None

# Display menu options
show_menu() {
    echo "*** Machine Learning Project Template Creator ***"
    echo "*** This script automates the creation of a structured template for machine learning projects, including directories and files. ***"
    echo "1. Project Name"
    echo "2. Exit"
}

# Validate project name
validate_project_name() {
    # Allow letters, underscores and dashes
    [[ "$1" =~ ^[a-zA-Z_][a-zA-Z_-]*$ ]]
}

# Create directories and files
create_project_structure() {
    local project_name="$1"
    # List main directories
    local dirs=(.venv bash-scripts data/raw data/versions/v1.0 data/versions/v1.1 deployments logs metrics models notebooks reports src)
    # List files
    local files=(.env .gitignore params.yml README.md requirements.txt notebooks/$project_name.ipynb bash-scripts/bash_clean.sh src/__init__.py src/eval.py src/deploy.py src/feature.py src/train.py src/cleaning.py src/split.py src/processor.py)

    # Create main directories
    for dir in "${dirs[@]}"; do
        mkdir -p "$project_name/$dir"
    done
    
    # Create files
    for file in "${files[@]}"; do
        touch "$project_name/$file"
    done

    # .gitignore content
    printf ".env\ndata/\nbash-scripts/\n.venv/\n" > "$project_name/.gitignore"

    echo "The $project_name folder and all its subdirectories have been successfully created!"
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice (1-2): " choice

    case $choice in
        1)
            read -p "Enter project name: " project_name
            if validate_project_name "$project_name"; then
                [ -d "$project_name" ] && echo "Project directory already exists!" || create_project_structure "$project_name"
            else
                echo "Invalid project name! Use only letters, underscores, and dashes."
            fi
            ;;
        2)
            echo "Goodbye! See you soon."
            exit 0
            ;;
        *)
            echo "Invalid selection!"
            ;;
    esac
done