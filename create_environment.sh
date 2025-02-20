#!/bin/bash
# user input his/her name
echo "enter your name"
read name
# these are files and folders that makes Application and their permitions
mkdir submission_reminder_$name
mkdir submission_reminder_$name/app
touch submission_reminder_$name/app/reminder.sh
mkdir submission_reminder_$name/modules
touch submission_reminder_$name/modules/functions.sh
mkdir submission_reminder_$name/assets
touch submission_reminder_$name/assets/submissions.txt
mkdir submission_reminder_$name/config
touch submission_reminder_$name/config/config.env
touch submission_reminder_$name/startup.sh
chmod +x submission_reminder_$name/startup.sh
chmod +x submission_reminder_$name/app/reminder.sh
chmod +x submission_reminder_$name/modules/functions.sh
# files population
echo "# This is the config file
ASSIGNMENT=\"Shell Navigation\"
DAYS_REMAINING=2" >> submission_reminder_$name/config/config.env
echo "student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Robert, Shell Basics, submitted
Prencipie, Shell Navigation, not submitted
Shamilla, Shell Navigation, not submitted
Irenee, Shell Navigation, not submitted
Nkurunziza, Git, submitted" >> submission_reminder_$name/assets/submissions.txt
cat >> submission_reminder_$name/app/reminder.sh <<EOF
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions \$submissions_file
EOF
cat >> submission_reminder_$name/modules/functions.sh <<EOF
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOF
# App setup
cat >> submission_reminder_$name/startup.sh <<EOF
#!/bin/bash
echo "Starting app.."
cd submission_reminder_$name
./app/reminder.sh  # FIXED: Removed extra directory prefix
EOF

