#!/bin/bash

# Check the status of the apache2 service and output it to a file
service apache2 status > apache2_status.txt

# Check if the service is running by looking for the word "running" in the status output
# grep -q: Searches for a pattern without an output; it returns 0 if the pattern is found.
if grep -q "running" apache2_status.txt; then
    echo "Apache2 is running"
else
    # If the service is not running, start the service
    service apache2 start
    # Send an email notification that the service was started
    echo "The apache2 service was stopped, errored, or inactive. The service has been started" | mail -s "Apache2 Service Status" user@example.com
# Ends the if statement
fi

# Clean up by removing the temporary status file
rm -f apache2_status.txt


# NOTE: To automate this script to check the server every 5 minutes, feel free to change the duration,
# add the following line to your crontab (crontab -e):
# */5 * * * * /root/apache_health_check.sh
# -e: Opens the crontab file for editing.
