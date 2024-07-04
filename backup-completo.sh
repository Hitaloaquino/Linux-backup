#!/usr/bin/env sh

# Diretorio de backup
## criar uma variavel para armazenar o conteudo do diretorio /opt
origem_backup="/opt"

# Criar um diretorio para colocar o backup do diretorio /opt
## mkdir -v /mnt/backup/opt

# diretorio de destino do backup
destino_backup="/mnt/backup/opt"

# formato do arquivo
## formato de data e hora
formato_data=$(date "+%d-%m-%Y %H:%M:%S")

## formato que o arquivo compactado terá no final
final_arquivo="backup-$formato_data.tar.gz"

# Local onde será aramazenado os logs
arquivo_log="/var/log/dia-backup.log"

# inicio de backup.
## o comando tar -czvf = local de destino do backup + formato do arquivo com tipo de compressão + local de origem do backup
## o comando abaixo é uma condicional = se o BACKUP for executado com sucesso, enviar um log com a mensagem "BACKUP SUCESSO", se não for realizado
## com sucesso enviar um log com a mansagem "ERROR BACKUP" para o local onde será armazenado os logs de sucesso e error.
if tar -czSf "$destino_backup/$final_arquivo" "$origem_backup"; then
   echo "[$formato_data] BACKUP SUCESSO.\n" >> $arquivo_log
else
   echo "[$formato_data] ERROR BACKUP.\n" >> $arquivo_log
fi

# excluir os backups que tiverem mais de 10 dias
find $destino_backup -mtime +10 -delete

# Criar um agendamento de tarefa de backup com o CRON
## digita logado como root o comando "crontab -e"
## digita esse comando na ultima linha do arquivo.
## 0 3 * * * /usr/local/sbin/backup-completo.sh
## o comando informado acima vai iniciar todos os dias as 03:00 e o passei o caminho onde está o script para ser excutado.

