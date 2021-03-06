# Ej_11.3.2.ps1
# Indicar los días que comprende el fichero,
#   mostrando el primer y último acceso

Set-Location 'F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos'

$hora1 = Get-Date

[string]$inicio = ""
[string]$final = ""

Get-content ".\access_log" | `
    ForEach-Object {
        $datos = $_ -split " ",12
        $fecha = $datos[3]
        if ($inicio -eq "") {$inicio = $fecha}
    }

$inicio = $inicio -replace "\[",""
$final = $fecha -replace "\[",""

"Fecha de inicio: $inicio"
"Fecha de final:  $final"
[datetime]$iniciof = ($inicio).substring(0,11)
[datetime]$finalf = ($final).substring(0,11)
$dias = ($finalf-$iniciof).Days + 1
"Días que comprende: $dias"

$hora2 = Get-Date

($hora2-$hora1).Seconds