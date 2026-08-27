#!/bin/bash

BACKUP_FILE="$1"
RESTORE_DB="bookingdb_restore"

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: ./scripts/restore.sh <backup-file>"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "Creating fresh database..."

docker exec booking-db psql -U bookinguser -d bookingdb -c "DROP DATABASE IF EXISTS $RESTORE_DB;"
docker exec booking-db psql -U bookinguser -d bookingdb -c "CREATE DATABASE $RESTORE_DB OWNER bookinguser;"

echo "Restoring backup..."

cat "$BACKUP_FILE" | docker exec -i booking-db psql -U bookinguser -d "$RESTORE_DB"

if [ $? -eq 0 ]; then
    echo "Restore completed successfully"
else
    echo "Restore failed"
    exit 1
fi
