# Ej_7.4.ps1
# Imprimir en un PDF el listado en forma de tabla de los programas
#   que aparecen en Agregar/Quitar programas de Windows,
#   quitando las actualizaciones

Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" `
    |Where-Object {$_.Name -notlike "*{*"} |Where-Object {$_.Name -notlike "*KB*"} `
    | Out-Printer "PDFCreator"