ROBOCOPY "\\MyTower.local\Documents" "D:\Docs\DOCUMENTOS_MyTower" /E /R:1 /Z /W:1 /V /tee /XF *.vmdk *.iso *.dmg /log:C:\Logs_Backup\log_copia_TorreBlanca.log
