# Ej_10.4.ps1
# Mover el directorio PROGRAMACION de FEBRERO a ENERO,
#    incluyendo sus subdirectorios, claro

Set-Location C:\

Move-Item -Path C:\PRACTICAS\FEBRERO\PROGRAMACION `
    -Destination C:\PRACTICAS\ENERO
