# Ej_11.3.8.ps1
# Con todos los puntos anteriores, hacer un informe en HTML
#    que se mostrará en el navegador

Set-Location 'F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos'

[string]$inicio = ""
[string]$final = ""
[string]$separa = "="*70

[long]$get  = 0
[long]$post = 0
[long]$otro = 0

[long]$win  = 0
[long]$lin = 0
[long]$otr = 0

$paginas = @{}
$codigos = @{}
$lista = @{}

[long]$bytes = 0

Get-content ".\access_log" | `
    ForEach-Object {
        $datos = $_ -split " ",12
        $fecha = $datos[3] -replace "\[",""
        if ($inicio -eq "") {$inicio = $fecha}
        
        $fecha = ($fecha).substring(0,11)
        
        $verbo = $datos[5] -replace "`"",""
        if ($verbo -eq "GET"){
            $get++
        }elseif($verbo -eq "POST"){
            $post++
        }else{
            $otro++
        }

        $browser = $datos[11]
        if ($browser -like "*Windows*"){
            $win++
        }elseif ($browser -like "*Linux*"){
            $lin++
        }else{
            $otr++        }

        $pag_act = $datos[6];
        if ($pag_act -like "*php*" -or $pag_act -like "*htm*"){
            if ($paginas.ContainsKey($pag_act)){
                $paginas[$pag_act]++
            }else{
                $paginas.Add($pag_act,1)
            }
        }
        
        $cod_act = $datos[8]
        if ($codigos.ContainsKey($cod_act)){
            $codigos[$cod_act]++
        }else{
            $codigos.Add($cod_act,1)
        }
        
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

$final = $datos[3] -replace "\[",""

[datetime]$iniciof = ($inicio).substring(0,11)
[datetime]$finalf = ($final).substring(0,11)
$dias = ($finalf-$iniciof).Days + 1

""
"I N F O R M E   D E   V I S I T A S   A   M I   S I T I O"
"========================================================="
"Fecha de inicio: $inicio"
"Fecha de final:  $final"
"Días que comprende: $dias"

$separa

"TIPOS DE PETICIONES AL SERVIDOR"
"-------------------------------"
"Peticiones GET:   $get"
"Peticiones POST:  $post"
"Otras peticiones: $otro"

$separa

"SISTEMAS OPERATIVOS DE LOS USUARIOS"
"-----------------------------------"
"Sistemas Windows:   $win"
"Sistemas Linux:     $lin"
"Otros sistemas:     $otr"

$separa

"PAGINAS MÁS VISITADAS"
"---------------------"
$paginas.GetEnumerator() `
    |Sort-Object -property Value -Descending `
    |Select-Object -first 20 `
    |Format-Table -AutoSize -Property Value,Name

$separa

"CODIGOS DE RESPUESTA DEL SERVIDOR"
"---------------------------------"
$codigos.GetEnumerator() `
    |Sort-Object -property Name `
    |Format-Table -AutoSize -Property Name,Value

$separa

"TRAFICO EN BYTES CURSADO POR DÍA"
"--------------------------------"
$lista.GetEnumerator() `
    |Sort-Object -property Name `
    |Format-Table -AutoSize -Property Name,Value
    
$paginas.Clear()
$codigos.Clear()
$lista.Clear()