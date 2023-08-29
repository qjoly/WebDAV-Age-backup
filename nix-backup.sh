#!/usr/bin/env nix-shell
#!nix-shell -i bash -p rclone age

# ------
# Purpose: Backup script that encrypts and sends files to kDrive
# Author: Quentin Joly
# Script Name: nix-backup.sh
# ------

rclone_config_file="$HOME/.config/rclone/rclone.conf"                           # Path to your rclone configuration file


# ------
rclone_config_file="$HOME/.config/rclone/rclone.conf"                           # Path to your rclone configuration file
# ------

age_public_key="age1whyd46g7za3q67mw9pkhvssqjse8d84t7ye5tprak4czhtrd05wsucwh8e" # Public key of your age token
webdav_directory_path="Backups/BarbeNoire"                                      # Directory in kDrive
rclone_conf_name="kDrive"                                                       # Name of your rclone configuration
paths_to_backup="$HOME/.thunderbird $HOME/.config"
script_to_execute_before_backup="echo 'Before Backup'"
script_to_execute_on_success="echo 'Notify Admin that backup is done'"
script_to_execute_on_fail="echo 'Notify Admin that backup failed'"

date_backup=$(date +%Y-%m-%d_%H:%M:%S)
archive_file=/tmp/archive_temp
#archive_file=$(mktemp)
age_temp_file=/tmp/${date_backup}.age

verifications () {
  if test -f "$rclone_config_file"; then
      echo "✅ rclone configuration exists."
  else
      echo "❌ $rclone_config_file does not exist !"
      sh -c "$script_to_execute_on_fail"
      exit 1
  fi
  
  if command -v rclone &> /dev/null
  then
      echo "✅ rclone binary is available."
  else
      echo "❌ rclone cannot be executed !"
      sh -c "$script_to_execute_on_fail"
      exit
  fi
  
  if command -v age &> /dev/null
  then
      echo "✅ age binary is available."
  else
      echo "❌ age cannot be executed !"
      sh -c "$script_to_execute_on_fail"
      exit
  fi
}

sh -c "$script_to_execute_before_backup"
verifications

tar cvfz $archive_file $paths_to_backup >/dev/null
if [ $? -eq 0 ] 
then 
  echo "✅ Archive created successfully" 
else 
  echo "❌ Could not create archive" 
  sh -c "$script_to_execute_on_fail"
  exit 1
fi

echo "Creating age archive..."
cat $archive_file | age -r $age_public_key > $age_temp_file

if [ $? -eq 0 ] 
then 
  echo "✅ Successfully crypt archive using age" 
else 
  echo "❌ Could not create file" 
  sh -c "$script_to_execute_on_fail"
  exit 1
fi

rclone copy --progress $age_temp_file $rclone_conf_name:$webdav_directory_path

if [ $? -eq 0 ] 
then 
  echo "✅ Successfully sended archive to kDrive" 
else 
  echo "❌ Could not send file"  
  sh -c "$script_to_execute_on_fail"
  exit 1
fi

sh -c "$script_to_execute_on_success"
