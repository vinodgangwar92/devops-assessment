#!/bin/bash

BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/bookingdb_$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"

docker exec booking-db pg_dump \
  -U bookinguser \
  -d bookingdb \
  > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully:"
    echo "$BACKUP_FILE"
else
    echo "Backup failed"
    exit 1
fi
