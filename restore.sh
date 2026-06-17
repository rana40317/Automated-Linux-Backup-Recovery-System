#!/bin/bash


echo "Available backup"
ls backup/*.tar.gz

echo ""

read -p "Enter backup filename:" BACKUP_FILE


tar -xzf "backup/$BACKUP_FILE" -C restorefile

if [ $? -eq 0 ]; then
	echo "Restore Sucessfull"

else
	echo "Restore Failed"
fi
