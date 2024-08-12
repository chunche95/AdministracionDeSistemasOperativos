# Ej_7.3.ps1
# Sacar la lista de los servicios que estén detenidos ordenados
#   por el site y mostrados en un objeto GridView

Get-Service |Where-Object {$_.status -eq "Stopped"} `
    |Sort-Object site |Ogv
    