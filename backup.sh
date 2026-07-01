#!/bin/bash

#Load  Confiuration File"

CONFIG_FILE="./config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
	echo "Configuration File not found"
	exit 1
fi

source "$CONFIG_FILE"

#Create Required Folders
mkdir -p "$DESTINATION_DIR"
mkdir -p "$LOG_DIR"

#Current Timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"
BACKUP_PATH="$DESTINATION_DIR/$BACKUP_FILE"
echo "Starting Backup."


#Create compressed Backup
tar -czf "$BACKUP_PATH" "$SOURCE_DIR"

#Check Backup Status
if [ $? -eq 0 ]; then
	echo "[$TIMESTAMP] Sucess: Backup File Created: $BACKUP_FILE" >> "$LOG_FILE"
	echo "BACKUP Sucessful"
	echo "Backup File: $DESTINATION_DIR/$BACKUP_FILE"
else
	echo "[TIMESTAMP] Failed: Backup File not Created" >>"$LOG_FILE"
	echo "Backup Failed"
	exit 1
fi

#Verify Backup
echo "Verifying Backup..."
if tar -tzf "$BACKUP_PATH" > /dev/null 2>&1; then
	echo "Backup Verification Sucessfull. " >> "$LOG_FILE"
	echo "$LOG_FILE"
else
	echo "Backup Verification Failed." >> "$LOG_FILE"
	exit 1
fi

#Delete Old Backups
find "$DESTINATION_DIR" -type f -name "*.tar.gz" -mtime +"$RETENTION_DAYS" -exec rm -f {} \;

echo "[$TIMESTAMP] Retention: Deleted Backups older than $RETENTION_DAYS days" >> "$LOG_FILE"



