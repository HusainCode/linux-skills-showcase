#!/bin/bash

# The script job: If memory usage exceeds the set percentage, the script will clear the caches.
# Then send a notifications email.

# Threshold for memory usage percentage %75
THRESHOLD=75

# Email for notifications
EMAIL="admin@admin.com"

# Check current memory usage
MEMORY_USAGE=$(free | awk '/^Mem/ {printf("%.0f"), $3/$2 * 100.0}')

# Function to clear caches
clear_caches() {
    echo 3 > /proc/sys/vm/drop_caches
    echo "Caches cleared."
}

# Check if memory usage exceeds the threshold
if [ "$MEMORY_USAGE" -gt "$THRESHOLD" ]; then
    clear_caches
    echo "Memory usage was $MEMORY_USAGE% and caches were cleared." | mail -s "Memory Cache Cleared" "$EMAIL"
else
    echo "Memory usage is within acceptable limits."
fi

# Print completion message
echo "Memory management script completed."
