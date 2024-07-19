#!/bin/bash

# This script locks a user's account in case user got fired or quit then archives their home directory and logs,
# You can also remove these directories to save the data while deactivating the account.

# Check if username is provided
if [ -z "$1" ]; then
  # if no username is provied, print an error message then exit
   echo "Error: No username was provided"
   echo "Usage: $0 username"
  exit 1
fi # Ends the if statement

USERNAME=$1

 # Check if the user exists
if ! id "$USERNAME" &>/dev/null; then
  # If the user does not exist, print an error message and exit
  echo "User $USERNAME does not exist."
  exit 1
fi # ends the if statment

# Lock the user's account
usermod --expiredate 1 $USERNAME
echo "User account $USERNAME has been locked."

# archive user home directory
HOME_DIR="/home/$USERNAME"
ARCHIVE_DIR="/archive/$USERNAME"
mkdir -p $ARCHIVE_DIR

if [ -d "$HOME_DIR" ]; then
  tar -czf $ARCHIVE_DIR/home_$USERNAME.tar.gz -C /home $USERNAME
  echo "Home directory for $USERNAME has been archived."
fi # ends the if statement

# Archive user's logs, assuming logs are in /var/log
LOG_DIR="/var/log"
USER_LOG_DIR="$LOG_DIR/$USERNAME"

if [ -d "$USER_LOG_DIR" ]; then
  tar -czf $ARCHIVE_DIR/logs_$USERNAME.tar.gz -C $LOG_DIR $USERNAME
  echo "Logs for $USERNAME have been archived."
fi # Ends the if statement

# Remove the user's home directory and logs
# uncomment out the following lines if you want to keep the files
# rm -rf $HOME_DIR
# echo "Home directory for $USERNAME has been removed."
# rm -rf $USER_LOG_DIR
# echo "Logs for $USERNAME have been removed."

echo "Account deactivation process for $USERNAME is complete."
