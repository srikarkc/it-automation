#!/bin/bash

# Define variables
SOURCE_DIR="/path/to/your_directory_to_backup"
DEST_DIR="/path/to/your_backup_destination_directory"
REMOTE_USER="your_remote_username"
REMOTE_HOST="your_remote_server"
LOG_FILE="/var/log/backup.log"

# Create a timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Start backup process
echo "Starting backup: $(date)" >> $LOG_FILE
rsync -avz --delete $SOURCE_DIR $REMOTE_USER@$REMOTE_HOST:$DEST_DIR/backup_$TIMESTAMP >> $LOG_FILE 2>&1

# Check the status of the backup operation
if [ $? -eq 0 ]; then
    echo "Backup completed successfully at $(date)" >> $LOG_FILE
else
    echo "Backup failed at $(date)" >> $LOG_FILE
fi

# Optional: remove backups older than 30 days from the destination
ssh $REMOTE_USER@$REMOTE_HOST "find $DEST_DIR -type d -mtime +30 -exec rm -rf {} \;" >> $LOG_FILE 2>&1

echo "Backup process finished." >> $LOG_FILE
