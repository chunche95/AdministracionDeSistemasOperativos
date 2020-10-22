# Ej_5.5.ps1
# Presentar en 4 columnas el nombre de los archivos de
#   c:\Windows que empiecen por A o por E, incluyendo
#   sus subdirectorios

Set-Location "C:\Windows\"
Get-ChildItem -path "C:\Windows\*" -Include "a*","e*" -recurse `
    |Format-Wide -Column 4