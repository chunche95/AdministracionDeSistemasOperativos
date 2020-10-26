write-host "Datos del sistema:"
New-Object System.io.DriveInfo "C:" | Format-List *
$drive = New-Object System.io.DriveInfo "C:"
$drive.DriveFormat
$drive.VolumeLabel

#11. C�mo mostrar el nombre de los archivos y el tama�o cuyo tama�o sea 79 bytes en powershell ?

gci |select name,length | where {$_.length -eq 76}


#10. C�mo mostrar el nombre de los archivos y el tama�o ordenados por tama�o
gci |select name,length |sort length �desc

Start-Job �Name GetFileList �Scriptblock {Get-ChildItem C:\ �Recurse}