# Ej_11.1.ps1
# Indicar cuantos servicios aparecen listados en el
#    fichero C:\Windows\System32\drivers\etc\services

Set-Location C:\
[int]$i = 0

Get-content C:\Windows\System32\drivers\etc\services | `
    ForEach-Object {
        if ($_ -like "#*" -or $_ -eq ""){
        }else{
            $i++
        }
    }

"Numero de servicios = $i"