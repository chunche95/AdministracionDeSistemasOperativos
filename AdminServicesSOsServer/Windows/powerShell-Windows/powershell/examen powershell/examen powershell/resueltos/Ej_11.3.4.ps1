# Ej_11.3.4.ps1
# Indicar cuántas visitas hay por sistema
#    operativo (Windows, Linux u otros)
Set-Location 'F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos'

[long]$win  = 0
[long]$lin = 0
[long]$otr = 0


Get-content ".\access_log" | `
    ForEach-Object {
        $datos = $_ -split " ",12
        $browser = $datos[11]
        if ($browser -like "*Windows*"){
            $win++
        }elseif ($browser -like "*Linux*"){
            $lin++
        }else{
            $otr++        }
    }

"Sistemas Windows:   $win"
"Sistemas Linux:     $lin"
"Otros sistemas:     $otr"