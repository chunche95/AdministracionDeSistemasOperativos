# Ej_10.5.ps1
# Copiar el archivo Ej_2_1.txt al directorio SISTEMAS
#    de ENERO, con el nombre Ej_3.1.txt

Set-Location C:\

Copy-Item -Path C:\PRACTICAS\FEBRERO\SISTEMAS\TEMA9\Ej_2_1.txt `
    -Destination C:\PRACTICAS\ENERO\SISTEMAS\Ej_3.1.txt -Confirm
