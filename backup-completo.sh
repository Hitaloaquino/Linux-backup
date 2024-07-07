#!/usr/bin/env sh
origem_backup="/opt"
mkdir -v /mnt/backup/opt
destino_backup="/mnt/backup/opt"
formato_data=$(date "+%d-%m-%Y %H:%M:%S")
final_arquivo="backup-$formato_data.tar.gz"
arquivo_log="/var/log/dia-backup.log"
if tar -czSf "$destino_backup/$final_arquivo" "$origem_backup"; then
   echo "[$formato_data] BACKUP SUCESSO.\n" >> $arquivo_log
else
   echo "[$formato_data] ERROR BACKUP.\n" >> $arquivo_log
fi

find $destino_backup -mtime +10 -delete