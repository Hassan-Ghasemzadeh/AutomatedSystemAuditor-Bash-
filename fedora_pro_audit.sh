#!/bin/bash
# Fedora System Manager Script
# This script provides basic system management functions for Fedora systems.

# =================================================================
# Description:    Advanced System Health & Security Auditor
# Author:         Hassan Ghasemzadeh
# License:        MIT
# =================================================================

LOG_DIR="/var/log/sys_audit"
BACKUP_DIR="/backups/system_config"
LOG_FILE="$LOG_DIR/audit_$(date +%Y%m%d).log"
BACKUP_FILE="$BACKUP_DIR/etc_backup_$(date +%Y%m%d).tar.gz"
DISK_THRESHOLD=80
ADMIN_EMAIL="hghasemzadeh38@gmail.com"

# Initialize environment
setup_env(){
    if [[EUID -ne 0]]; then
        echo "Error: This script must be run as root." >&2
            exit 1
    fi
    mkdir -p $LOG_DIR
    touch $LOG_FILE
}
# Log messages
log_message(){
    local level=$1
    local message=$2
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $message" | tee -a "$LOG_FILE"
}

# Back up file
perform_backup() {
    log_message "INFO" "Starting backup of /etc configuration..."
    tar -czf "$BACKUP_FILE" /etc 2>> "$LOG_FILE"
    
    if [ $? -eq 0 ]; then
        log_message "SUCCESS" "Backup saved to $BACKUP_FILE"
    else
        log_message "ERROR" "Backup failed!"
    fi
}

send_report() {
    log_message "INFO" "Sending report to $ADMIN_EMAIL..."
    mail -s "Fedora Audit Report - $(hostname)" "$ADMIN_EMAIL" < "$LOG_FILE"
    log_message "INFO" "Report dispatched successfully."
}

# Check for updates
check_updates(){
    log_message "Warning" "Security updates are available. Please run 'dnf update' to install them."
    dnf check-update --security &>> "$LOG_FILE"

    if[[$? -eq 100]]; then
        log_message "Warning" "Security updates are available."
    else
        log_message "Info" "System is up to date."
    fi
}

#  Audit SELinux & FireWall
audit_security(){
    log_message "Info" "Auditing system security..."
    local selinux_status=$(getenforce)
    log_message "INFO" "SELinux Status: $selinux_status"

    if systemctl is-active --quiet firewalld; then
        log_message "INFO" "Firewall is active."
    else
        log_message "CRITICAL" "Firewall is INACTIVE!"
    fi
}

# Monitor Resources
check_resources() {
    log_message "INFO" "Checking disk usage..."
    df -h | grep '^/dev/' | while read -r line; do
        usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
        partition=$(echo "$line" | awk '{print $6}')
        
        if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
            log_message "ALERT" "Partition $partition is at $usage% capacity!"
        fi
    done
}


# --- Main Execution ---
main() {
    setup_env
    log_message "START" "Starting Fedora System Audit"
    
    perform_backup
    check_updates
    audit_security
    check_resources
    
    log_message "END" "Audit completed successfully. Report: $LOG_FILE"
    send_report
}

# Execute main function with arguments
main "$@"
