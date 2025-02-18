### How It Works:

1.Run the script:
   Execute create_environment.sh.
 It prompts you for your name and creates a directory named submission_reminder_{yourName}.
2.Directory Structure:  
   - scripts → Contains reminder.sh, functions.sh, and startup.sh  
   - config → Contains config.env for configurations
   - data → Contains submissions.txt with student records  

3.Startup Process:
   - Running startup.sh executes reminder.sh, which alerts students about assignment deadlines.  
   - functions.sh provides helper functions for the application.  
   - config.env defines configurations like the reminder interval.  

4.Testing:  
   - Navigate to submission_reminder_{yourName}  
   - Run ./scripts/startup.sh to start the application.
