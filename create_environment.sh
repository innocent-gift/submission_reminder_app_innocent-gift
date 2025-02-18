#!/bin/bash

# Prompt user for their name
read -p "Enter your name: " user_name

# Replace spaces with underscores in the name
dir_name="submission_reminder_${user_name// /_}"

# Create the directory structure
mkdir -p "$dir_name"/{app,modules,assets,config}

# Create necessary files
touch "$dir_name"/app/reminder.sh
touch "$dir_name"/modules/functions.sh
touch "$dir_name"/assets/submissions.txt
touch "$dir_name"/config/config.env
touch "$dir_name"/startup.sh
chmod +x "$dir_name"/startup.sh
echo "Directory structure created under: $dir_name"

