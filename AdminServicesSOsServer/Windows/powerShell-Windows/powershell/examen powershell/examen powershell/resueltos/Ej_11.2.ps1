# Ej_11.2.ps1
# Contar la cantidad de servicios TCP y UDP
#    hay en el fichero indicado anteriormente

Set-Location C:\
[int]$tcp = 0
[int]$udp = 0

Get-content C:\Windows\System32\drivers\etc\services | `
    ForEach-Object {
        if ($_ -like "#*" -or $_ -eq ""){
        }else{
            if($_ -like "*/tcp*"){
                $tcp++;
            }elseif($_ -like "*/udp*"){
                $udp++;
            }
        }
    }

"Numero de servicios TCP = $tcp"
"Numero de servicios UDP = $udp"

