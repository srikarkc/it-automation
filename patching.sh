#!/bin/bash

# Define log file location
LOG_FILE="/var/log/autopatch.log"

# Update package list
echo "Updating package list..." | tee -a $LOG_FILE
apt-get update | tee -a $LOG_FILE

# Upgrade all packages
echo "Upgrading packages..." | tee -a $LOG_FILE
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade | tee -a $LOG_FILE

# Optional: Full upgrade (dist-upgrade) can be used to perform upgrades that may involve changing dependencies, adding or removing new packages
# echo "Performing full upgrade..." | tee -a $LOG_FILE
# DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade | tee -a $LOG_FILE

# Clean up unnecessary packages and dependencies
echo "Cleaning up unnecessary packages..." | tee -a $LOG_FILE
apt-get -y autoremove | tee -a $LOG_FILE
apt-get -y autoclean | tee -a $LOG_FILE

# Log completion
echo "Patch management process completed at $(date)" | tee -a $LOG_FILE
