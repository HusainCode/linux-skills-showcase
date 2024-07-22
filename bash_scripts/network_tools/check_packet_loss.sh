#!/bin/bash

# This script checks for packet loss and saves the result in a text file if detected.

# Ping a remote server and save the results to a file
ping -c 4 google.com > ping_results.txt

# Extract the packet loss percentage
packet_loss=$(grep -oP '\d+(?=% packet loss)' ping_results.txt)

# Print the packet loss percentage
echo "Packet loss: ${packet_loss}%"

# Define the threshold for packet loss.
threshold=0

# Check if the packet loss percentage is greater than the threshold
if [ "$packet_loss" -gt "$threshold" ]; then
  echo "There is a packet loss."
  # Restart the networking service if there is packet loss
  sudo service networking restart
else
  echo "No packet loss@."
fi

# Clean up
rm ping_results.txt