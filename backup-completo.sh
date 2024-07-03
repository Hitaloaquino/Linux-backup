#!/usr/bin/env sh

# Diretorio de backup
backup_path="/opt"

# diretorio de destino do backup
destino_backup="/mnt/backup"

# formato do arquivo
formato_data=$(date "+%d-%m-%Y %H:%M:%S")
final_arquivo="backup-$formato_data.tar.gz"

# Local onde será aramazenado os logs?
arquivo_log="/var/log/dia-backup.log"

# inicio de backup.
if  tar -czSpf "$destino_backup/$final_arquivo" "$backup_path"; then
    printf "[$formato_data] BACKUP SUCESSO.\n" >> $arquivo_log
else
    printf "[$formato_data] BACKUP ERROOOOOR.\n" >> $arquivo_log
fi

# echo "$formato_data $destino_backup" >> $arquivo_log

