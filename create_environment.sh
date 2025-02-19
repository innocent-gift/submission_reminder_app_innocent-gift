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
chmod +x "$dir_name"/app/reminder.sh
echo "Directory structure created under: $dir_name"
cat >> "$dir_name"/app/reminder.sh <<EOF
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
cat >> "$dir_name"/modules/functions.sh <<EOF
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
cat >>  "$dir_name"/app/reminder.sh<<EOF
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Robert, Shell Basics, submitted
Prencipie, Shell Navigation, not submitted
Shamilla, Shell Navigation, not submitted
Irenee, Shell Navigation, not submitted
Nkurunziza, Git, submitted
EOF
cat >> "$dir_name"/config/config.env <<EOF
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
cat >> "$dir_name"/startup.sh <<EOF
#!/bin/bash
./app/reminder.sh
EOF

