# Ej_4.2.ps1
# Listar los archivos de c:\windows que empiecen por a

Get-ChildItem -path "C:\Windows\*" -include "a*"
