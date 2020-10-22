# BackUp Script.
#
# This is a demo backup script in powershell version 5.1, in this case using this script for call other script 
# for create the multiples backups, unsing the time of machine to differently the folderes. And finally, send the email
# in my account with the log folder.

set fechasistema=backupsServer_%date:~6,4%%date:~3,2%%date:~0,2%
mkdir e:\BACKUP_SERVIDOR\%fechasistema%
winscp /console /script=C:\Users\Pau\Desktop\Backup\backup-servidor.txt /log=E:\BACKUP_SERVIDOR\log_.txt
powershell.exe C:\Users\Pau\Desktop\Backup\send_mail_backup_Alert.ps1
