# Projeto-backup-linux
# 04 de Julho de 2024 - Hitalo Aquino
# ESTE É O CENARIO

Seu gerente informa, temos uma aplicação que roda no linux na pasta ```/opt ```e precisamos garantir que o conteúdo que está la seja feito o backup, ```DIARIAMENTE```,
sua tarefa sera criar uma automação em script ```bash``` que execute diariamente as 03:00 DA MADRUGADA. Utilize-se das ferramentas do linux para fazer isso 
um exemplo é o ```cron e git``` e registre os logs do seu script usando o ```echo``` assim ficará mais fácil identificar uma etapa que vir a falhar nos testes.
Depois poste seu script no ```github``` como forma de resultado e nao esqueçam de testar a solução e documentar em formato ```MarkDown``` também é bom.

## Tecnologias Utilizadas

- [VirtualBox](https://www.virtualbox.org/): é um software de virtualização de código aberto desenvolvido pela Oracle, que permite criar e executar máquinas virtuais em um computador físico.
- [Ubuntu Server](https://ubuntu.com/download/server/): é um popular sistema operacional baseado em Linux, que é gratuito e de código aberto, podendo ser usado num computador ou servidor.
- [Putty](https://www.putty.org/): é um terminal de simulação open source que foi desenvolvido para agir como um cliente de conexões seguras através de protocolos raw TCP, Telnet, rlogin e porta serial. 
- [Notepad++](https://notepad-plus-plus.org/downloads/): é um pequeno e rápido editor de texto de código aberto, para Windows, que permite trabalhar com arquivos de textos simples e código-fonte de diversas linguagens de programação.
- [GitHub](https://github.com/): é um serviço baseado em nuvem que hospeda um sistema de controle de versão (VCS) chamado Git. Ele permite que os desenvolvedores colaborem e façam mudanças em projetos compartilhados enquanto mantêm um registro detalhado do seu progresso.
- [Visual Studio Code](https://code.visualstudio.com/): é um editor de código-fonte leve, mas poderoso, executado em sua área de trabalho e disponível para Windows, macOS e Linux. Ele vem com suporte integrado para JavaScript, TypeScript e Node.js e possui um rico ecossistema de extensões para outras linguagens e tempos de execução (como C, C#, Java, Python, PHP, Go, .NET).


## Lógica do código

Abaixo contem um script de backup de roda na plataforma linux, para realizar a tarefa solicitada pelo Gerente onde temos uma aplicação que está rodando no diretório ```/opt``` e faremos o backup para o diretorio ```/mnt/backup/opt``` diariamente as 03:00 da MADRUGADA, 
e tambem utilizaremos o CRON para realizar o agendamento de forma automatica.

## Script de backup


1. Criei um arquivo com a extensão ```.sh ``` com o comando ``` nano backup-completo.sh```
2. Dentro desse arquivo que foi criado o seguinte script:

```
#!/usr/bin/env sh
origem_backup="/opt"
mkdir -v /mnt/backup/opt
destino_backup="/mnt/backup/opt"
formato_data=$(date "+%d-%m-%Y %H:%M:%S")
final_arquivo="backup-$formato_data.tar.gz"
arquivo_log="/var/log/dia-backup.log"
if tar -cvzf "$destino_backup/$final_arquivo" "$origem_backup"; then
   echo "[$formato_data] BACKUP SUCESSO.\n" >> $arquivo_log
else
   echo "[$formato_data] ERROR BACKUP.\n" >> $arquivo_log
fi

find $destino_backup -mtime +10 -delete
```
3. Salvei o arquivo com o nome ```backup-completo.sh``` e movi o mesmo para o diretorio ```/usr/local/sbin``` para facilitar na hora de executar o script com o ```cron```

4. Depois foi criado uma agendamento de tarefa com o ```cron``` , digitei logado como ```root```o comando ```crontab -e``` e digitei na ultima linha o seguinte comando: ```0 3 * * * /usr/local/sbin/backup-completo.sh```, se precisar saber quais paramentos tem que configurar dentro do ```crontab``` recomendo esse site: [crontab guru](https://crontab.guru/), abaixo o arquivo ```crontab``` aberto observe a ultima linha. 

```
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

# o comando informado é executado diariamente as 03:00 com o caminho de onde está o script.
0 3 * * * /usr/local/sbin/backup-completo.sh
```

# Etapa do script !!!!

1. Qual é o tipo de shell que vai ser chamado?
```
#!/usr/bin/env sh
```
2.Criar uma variavel para armazenar o conteudo do diretorio /opt
```
origem_backup="/opt"
```
3. Criar um local para colocar o backup do diretorio /opt.
```
mkdir -v /mnt/backup/opt
```
4. Local de destino do backup.
```
destino_backup="/mnt/backup/opt"
```
5. Formato de data e hora.
```
formato_data=$(date "+%d-%m-%Y %H:%M:%S")
```
6. Formato que o arquivo compactado terá no final.
```
final_arquivo="backup-$formato_data.tar.gz"
```
7. Local onde será armazenado os logs.
```
arquivo_log="/var/log/dia-backup.log"
```

8. inicio de backup:

Um exemplo:```tar (opções) [fonte][destino]```

O comando ```tar -cvzf "$destino_backup/$final_arquivo" "$origem_backup" ``` tem a seguinte :
```
-c: Cria um novo arquivo .tar;
-v: Lista todos os arquivos processados;
-z: Utiliza o gzip para compactar e descompactar os arquivos .tar.gz;
-f: Indica que o destino é um arquivo em disco, e não uma unidade de fita magnética;
```
O comando ```if , else , fi```é uma condicional se o BACKUP for executado com sucesso, enviar uma mensagem ```BACKUP SUCESSO```, se não for realizado com sucesso enviar uma mansagem ```ERROR BACKUP``` para o local onde será armazenado os logs de sucesso e error.
```
if tar -cvzf "$destino_backup/$final_arquivo" "$origem_backup"; then
   echo "[$formato_data] BACKUP SUCESSO.\n" >> $arquivo_log
else
   echo "[$formato_data] ERROR BACKUP.\n" >> $arquivo_log
fi

# excluir os backups que tiverem mais de 10 dias
find $destino_backup -mtime +10 -delete
```
9. Criar um agendamento de tarefa de backup com o comando  ```cron```, digite logado como ```root``` o comando ```crontab -e```,em seguida o arquivo com as configurações do ```crontab```então digite esse comando na ultima linha do arquivo ```0 3 * * * /usr/local/sbin/backup-completo.sh``` o comando informado vai iniciar diariamente as 03:00 e o caminho onde está o script para ser excutado. 

# Espero ter explicado todas as etapas do script, muito obrigado !!!!!