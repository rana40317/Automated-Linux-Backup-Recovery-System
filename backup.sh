
#!/bin/bash

#Source folder for backup
SOURCE_DIR="./files"

#Destination folder for backup
DESTINATION_DIR="./backup"

#Log folder and file
LOG_DIR="./log"
LOG_FILE="$LOG_DIR/backup.log"

#Retention Policy
RETENTION_DAY=7

#User Details for rsync
REMOTE_USER=user
REMOTE_HOST="192.168.1.10"
REMOTE_DIR="/home/user/remote_dir"




#Current TimeStamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

#Backup filename
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"

#create a backup file if it odesn't exist

mkdir -p "$DESTINATION_DIR"
mkdir -p "$LOG_DIR"

echo "Starting Backup"

#create compressed backup
tar -czf "$DESTINATION_DIR/$BACKUP_FILE" "$SOURCE_DIR"

#check wheather backup succeded or not
if [ $? -eq 0 ]; then
	echo "[$TIMESTAMP] Sucess : $BACKUP_FILE created" >> "$LOG_FILE"
	echo "Backup Sucessfull"
	echo "Backup File: $DESTINATION_DIR/$BACKUP_FILE"
else
	echo "[$TIMESTAMP] FAILED : Backup File Creation Failed" >>"$LOG_FILE"
	echo "Backup Failed"
fi

#Delete Old Backup
find "$DESTINATION_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAY -exec rm -f {} \;
echo "[TIMESTAMP] RETENTION : Backup Deleted older than $RETENTION_DAY Days" >>$LOG_FILE


#Rsync
rsync -avz backup/*.tar.gz remote-backup/
