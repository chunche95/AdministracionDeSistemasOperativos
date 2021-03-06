# Ej_11.3.6.ps1
# Indicar el número de entradas según el código de respuesta del servidor

Set-Location 'F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos'
$codigos = @{}

Get-content ".\access_log" | `
    ForEach-Object {
        $datos = $_ -split " ",12
        $cod_act = $datos[8]
        if ($codigos.ContainsKey($cod_act)){
            $codigos[$cod_act]++
        }else{
            $codigos.Add($cod_act,1)
        }
    }

$codigos.GetEnumerator() `
    |Sort-Object -property Name `
    |Format-Table -AutoSize -Property Name,Value
    
$codigos.Clear()
