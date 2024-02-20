#!/bin/bash

# System Monitoring with Alerting
# Configuration
ADMIN_EMAIL="admin@example.com"
LOG_FILE="/var/log/system_monitoring.log"

# Thresholds
CPU_THRESHOLD=80
DISK_THRESHOLD=90
MEM_THRESHOLD=80

# Function to check CPU usage
check_cpu() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    cpu_usage=${cpu_usage%.*} # Convert to integer
    if [ $cpu_usage -gt $CPU_THRESHOLD ]; then
        echo "High CPU usage detected: ${cpu_usage}%"
        echo "CPU usage is above threshold at ${cpu_usage}%" | mail -s "High CPU Alert" $ADMIN_EMAIL
    fi
}

# Function to check Disk usage
check_disk() {
    disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    if [ $disk_usage -gt $DISK_THRESHOLD ]; then
        echo "High Disk usage detected: ${disk_usage}%"
        echo "Disk usage is above threshold at ${disk_usage}%" | mail -s "High Disk Alert" $ADMIN_EMAIL
    fi
}

# Function to check Memory usage
check_memory() {
    mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    mem_usage=${mem_usage%.*} # Convert to integer
    if [ $mem_usage -gt $MEM_THRESHOLD ]; then
        echo "High Memory usage detected: ${mem_usage}%"
        echo "Memory usage is above threshold at ${mem_usage}%" | mail -s "High Memory Alert" $ADMIN_EMAIL
    fi
}

# Logging start
echo "Starting system monitoring checks: $(date)" >> $LOG_FILE

# Perform checks
check_cpu >> $LOG_FILE 2>&1
check_disk >> $LOG_FILE 2>&1
check_memory >> $LOG_FILE 2>&1

# Logging end
echo "System monitoring checks completed: $(date)" >> $LOG_FILE
