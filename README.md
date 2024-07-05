# Projeto-backup-linux
# 04 de Julho de 2024 - Hitalo Aquino
# ESTE É O CENARIO

Pense no seguinte cenário.
Seu gerente diz: Temos uma aplicação que roda na pasta /opt.
Precisamos garantir que o conteúdo que está la seja feito o backup, DIARIAMENTE,sua tarefa sera criar uma automação em script bash que execute isso as 03:00 DA MADRUGADA todos os dias.
Utilize-se das ferramentas do linux para fazer isso um exemplo é o cron e git e registre os logs do seu script usando o “echo” assim ficará mais fácil identificar uma etapa que vir a falhar nos testes.
Depois poste seu script no github como forma de resultado e nao esqueçam de testar a solução e documentar em formato MarkDown também é bom.

## Tecnologias Utilizadas

- [VirtualBox](https://www.virtualbox.org/) (veja o guia de instalação [aqui](https://www.virtualbox.org/wiki/Downloads)) : é um software de virtualização de código aberto desenvolvido pela Oracle, que permite criar e executar máquinas virtuais em um computador físico.
- **Ubuntu**: é um popular sistema operacional baseado em Linux, que é gratuito e de código aberto, podendo ser usado num computador ou servidor.
- **Putty**: um terminal de simulação open source que foi desenvolvido para agir como um cliente de conexões seguras através de protocolos raw TCP, Telnet, rlogin e porta serial. 
- **Notepad++**: é um pequeno e rápido editor de texto de código aberto, para Windows, que permite trabalhar com arquivos de textos simples e código-fonte de diversas linguagens de programação.

## Lógica do código

Aqui abaixo contem um script de backup de roda na plataforma linux, para realizar a tarefa solicitada pelo Gerente onde temos uma aplicação que 
está rodando no diretório /opt e faremos o backup para o diretorio /mnt/backup/opt diariamente as 03:00 da MADRUGADA, 
e tambem utilizaremos o CRON para realizar o agendamento de forma automatica.

# S


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






