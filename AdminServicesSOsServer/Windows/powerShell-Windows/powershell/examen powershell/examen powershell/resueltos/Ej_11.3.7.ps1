# Ej_11.3.7.ps1
# Calcular la suma de bytes transferidos por día

Set-Location 'F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos'
$lista = @{}
[long]$bytes = 0

Get-content ".\access_log" | `
    ForEach-Object {
        $datos = $_ -split " ",12
        $fecha = ($datos[3] -replace "\[","").substring(0,11)
        if ($datos[9] -eq "-"){
            $bytes = 0
        }else{
            $bytes = $datos[9]
        }
        if ($lista.ContainsKey($fecha)){
            $lista[$fecha] += $bytes
        }else{
            $lista.Add($fecha,$bytes)
        }
    }

$lista.GetEnumerator() `
    |Sort-Object -property Name `
    |Format-Table -AutoSize -Property Name,Value
    
$lista.Clear()
