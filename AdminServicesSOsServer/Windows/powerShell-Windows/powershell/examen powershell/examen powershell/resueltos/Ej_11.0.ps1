
$finicial = ""

Set-Location 'F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos'

Get-Content '.\access_log' | ForEach-Object{
        $datos =  $_ -split " "
        $datos[3] = $datos[3] -replace "\[",""
        if ($finicial -eq ""){$finicial = $datos[3]}
        
    }
    
"Fecha inicial: $finicial"
"Fecha final:   "+$datos[3]

[datetime]$inicial = ($finicial).substring(0,11)
[datetime]$final   = ($datos[3]).substring(0,11)

$dias = ($final-$inicial).days + 1
"Días comprendidos: $dias"
