# Ej_18.11.ps1
# 18.11. Eliminar a los usuarios cuyo nombre empieza por “M”
#
[string]$usuario = $null

$conexion = [ADSI]"WinNT://."
$conexion.PSBase.Children | `
    Where-Object {$_.PSBase.SchemaClassName -eq 'user' -and $_.Name -like "M*"} | `
    foreach{
        $usuario = $_.Name
        "Borrando $usuario..."
        $conexion.Delete('user',$usuario)
    }
