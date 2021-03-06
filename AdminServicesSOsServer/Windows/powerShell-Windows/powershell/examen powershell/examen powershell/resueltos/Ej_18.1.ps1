# Ej_18.1.ps1
# 18.1. Crear los grupos, con su descripción,
# que se presentan en el fichero 
# http://cursos.integra-gestion.com/AdeR/material/Grupos_KKFU_SA.txt

Set-Location "F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$conexion = [ADSI]”WinNT://.”

Get-Content -Path ".\Grupos_KKFU_SA.txt" | `
    ForEach-Object {
        $datos = $_ -split "`t"
        $objGroup = $conexion.Create('group',$datos[0])
        $objGroup.Put('description',$datos[1])
        $objGroup.SetInfo()
        "Creando grupo "+$datos[0]
    }

Remove-Variable datos,conexion,objGroup
