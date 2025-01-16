#!/bin/bash
# Configuration
DB_NAME="DB_NAME"
DB_USER="DB_USER"
DB_PASS="DB_PASS"
BACKUP_DIR="/home/backup/"
RETAIN=30
TIME=$(date +"%Y%m%d")
BACKUP_FILE="${BACKUP_DIR}/${TIME}_${DB_NAME}.sql.gz"

# Check backup dir
[[ ! -d "$BACKUP_DIR" ]] && mkdir -p "$BACKUP_DIR"

# Backup the database and compress it
echo "Backing up database '$DB_NAME'..."
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" | gzip > "$BACKUP_FILE"
[ $? -eq 0 ] && STATUS=1 || STATUS=0

# Remove backups older than retain days
echo "Remove Older Backup"
find "$BACKUP_DIR" -maxdepth 1 -type f -name "*.sql.gz" -mtime +$RETAIN -delete;

[[ $STATUS -eq 1 ]] && echo "Backup created on $BACKUP_FILE" || echo "Backup not created"