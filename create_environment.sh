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

# Writing reminder.sh
cat > "$dir_name"/app/reminder.sh <<EOF
#!/bin/bash

# Get the script directory
script_dir="\$(dirname "\$0")"

# Source environment variables and helper functions
source "\$script_dir/../config/config.env"
source "\$script_dir/../modules/functions.sh"

# Path to the submissions file
submissions_file="\$script_dir/../assets/submissions.txt"

# Ensure the file is not empty
if [[ ! -s "\$submissions_file" ]]; then
    echo "No submission records found."
    exit 1
fi

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOF

# Writing functions.sh
cat > "$dir_name"/modules/functions.sh <<EOF
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"

    while IFS=, read -r student assignment status; do
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOF

# Writing submissions.txt (Corrected Path)
cat > "$dir_name"/assets/submissions.txt <<EOF
student,assignment,submission status
Chinemerem,Shell Navigation,not submitted
Chiagoziem,Git,submitted
Divine,Shell Navigation,not submitted
Anissa,Shell Basics,submitted
Robert,Shell Basics,submitted
Prencipie,Shell Navigation,not submitted
Shamilla,Shell Navigation,not submitted
Irenee,Shell Navigation,not submitted
Nkurunziza,Git,submitted
EOF

# Writing config.env
cat > "$dir_name"/config/config.env <<EOF
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Writing startup.sh (Corrected)
cat > "$dir_name"/startup.sh <<EOF
#!/bin/bash
cd "\$(dirname "\$0")" || exit
./app/reminder.sh
EOF

