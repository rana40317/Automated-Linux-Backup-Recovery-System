
#!/bin/bash

#Source folder for backup
SOURCE_DIR="./files"

#Destination folder for backup
DESTINATION_DIR="./backup"

#Current TimeStamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

#Backup filename
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"

#create a backup file if it odesn't exist

mkdir -p "$DESTINATION_DIR"

echo "Starting Backup"

#create compressed backup
tar -czf "$DESTINATION_DIR/$BACKUP_FILE" "$SOURCE_DIR"

#check wheather backup succeded or not
if [ $? -eq 0 ]; then
	echo "Backup Sucess"
	echo "Backup FIle: $DESTINATION_DIR/$BACKUP_FILE"
else
	echo "Backup Failed"
fi


