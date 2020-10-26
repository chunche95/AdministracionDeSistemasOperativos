# Ej_5.1.ps1
# Obtener un listado de los archivos de c:\Archivos de programa que
#   empiecen por A en todos los subdirectorios y presentarlo en forma
#   de tabla autoajustada

Get-ChildItem -path "C:\Program Files\*" `
    -Include "a*" -Recurse |Format-Table -AutoSize
