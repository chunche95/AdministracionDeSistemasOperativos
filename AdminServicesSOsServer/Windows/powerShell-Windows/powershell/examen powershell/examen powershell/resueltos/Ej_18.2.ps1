# Ej_18.2.ps1
# 18.2. Crear los usuarios locales indicados en el fichero
# http://cursos.integra-gestion.com/AdeR/material/Usuarios_KKFU_SA.txt,
# teniendo en cuenta que el fichero presenta la separación de
#  campos por el carácter | y que los campos están delimitados por “

Set-Location "F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"
$conexion = [ADSI]”WinNT://.”

Get-Content -Path ".\Usuarios_KKFU_SA.txt" | `
    ForEach-Object {
        $datos = $_ -split "\|"
        $datos = $datos -replace "`"",""
        $objUser = $conexion.Create('user',$datos[1])
        $objUser.SetPassword($datos[2])
        $objUser.PSBase.InvokeSet('FullName',$datos[0])
        $objUser.PSBase.InvokeSet('Description',$datos[0])
        $objUser.SetInfo()
        "Creando usuario "+$datos[0]
    }

Remove-Variable conexion,datos,objUser
