#!/bin/bash

rclone_configuration="kDrive"
host="BarbeNoire"
limit_number_of_backup=10
days_to_keep=4

number_of_backup=$(rclone ls $rclone_configuration:/Backups/$host/ | wc -l)

echo "list of backups:"
rclone ls $rclone_configuration:/Backups/$host/


echo "Number of backups: $number_of_backup"
if [ $number_of_backup -gt $limit_number_of_backup ]; then
    echo "❌ Too many backups (limit: $limit_number_of_backup), deleting the oldest one"
else
    echo "✅ No need to prune"
    exit 0
fi

oldest_backup=$(rclone ls $rclone_configuration:/Backups/$host/ | sort -k 2 | head -n 1 | rev | cut -d' ' -f 1 | rev)
echo " Oldest backup: $oldest_backup"

date_oldest_backup=$(echo $oldest_backup | sed 's/\.age$//' | cut -d'_' -f 1)
echo " Date of oldest backup: $date_oldest_backup"

epoch_time=$(date -d "$date_oldest_backup" +%s)
current_epoch_time=$(date +%s)
time_difference=$(( (current_epoch_time - epoch_time) / 86400 ))  # 86400 seconds in a day
echo " Number of days since backup creation: $time_difference days"

if [ $time_difference -gt $days_to_keep ]; then
    echo "❌ Backup is older than $days_to_keep days, deleting it"
    rclone delete $rclone_configuration:/Backups/$host/"$oldest_backup" --dry-run
else
    echo "✅ Backup is not older than $days_to_keep days, no need to prune"
    exit 0
fi

