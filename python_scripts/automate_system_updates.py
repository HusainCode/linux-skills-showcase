import subprocess
import logging

# Description: This script automates system updates.
# To automate it, open crontab -e and add:
# Example: 0 2 * * * /usr/bin/python3 /path/to/automate_updates.py
# This will run the script every day at 2 AM. Adjust the schedule as needed.

# Set up logging to record events, messages, or errors in a log file
# The format includes timestamps for each log entry
logging.basicConfig(filename='/var/log/automate_updates.log', level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

def update_system():
    try:
        # Update the package list
        subprocess.run(["sudo", "apt-get", "update"], check=True)
        logging.info("Package list has been updated.")

        # Upgrade all packages
        subprocess.run(["sudo", "apt-get", "upgrade", "-y"], check=True)
        logging.info("Packages upgraded successfully.")

        # Log that the system update is completed
        logging.info("The system update completed.")

    except subprocess.CalledProcessError as e:
        # Log any error that occurs during the subprocess calls
        logging.error(f"An error occurred: {e}")

if __name__ == "__main__":
    # Log that the system update process has started
    logging.info("The system update has started.")

    # Run the system update function
    update_system()

    # Log that the system update process has finished
    logging.info("The system has been updated.")

