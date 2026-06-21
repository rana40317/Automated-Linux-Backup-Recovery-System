#!/bin/bash

VOLUME_NAME="backup_data"
BACKUP_DIR="./docker_backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="docker_volume_backup_$TIMESTAMP.tar.gz"


mkdir -p "$BACKUP_DIR"

docker run --rm \
	-v "VOLUME_NAME":/data \
	-v "$PWD/$BACKUP_DIR":/backup \
	nginx:latest \
	sh -c "echo 'Docker Backup Test' > /data/project_data.txt && tar -czf /backup/$BACKUP_FILE -C /data ."
if [ $? -eq 0 ]; then
	echo "Docker Volume Backup Created: $BACKUP_DIR/$BACKUP_FILE"
else
	echo "Docker Volume Backup Failed"
fi
	#tar -czf "/backup/$BACKUP_FILE" /data
#echo "Docker Volume Backup Created: $BACKUP_DIR/$BACKUP_FILE"



