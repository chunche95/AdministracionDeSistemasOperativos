# Ej_8.4.ps1
# Crear una variable de entorno llamada HoraAct
#    que contenga la hora de ese momento. Mostrarla,
#    borrarla y volver a mostrar todas las variables de entorno.

Set-Location Env:

$hora = Get-Date
New-Item -Path . -Name "HoraAct" -Value ($hora)

"Variable:"
Get-ChildItem -Path "HoraAct"

Remove-Item "HoraAct"

"Nuevo listado:"

Get-ChildItem